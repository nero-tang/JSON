//
//  BaseTests.swift
//  JSONTests
//
//  Created by Nero on 2020-02-19.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
@testable import JSON

class BaseTests: TestCase {
    
    func testInit() {
        guard let json0 = try? JSON(data: self.testData) else {
            XCTFail("Unable to parse testData")
            return
        }
        XCTAssertEqual(json0.arrayValue.count, 3)
        XCTAssertEqual(JSON("123").description, "123")
        XCTAssertEqual(JSON(["1": "2"])["1"].string!, "2")

        do {
            let object: Any = try JSONSerialization.jsonObject(with: self.testData, options: [])
            let json2 = JSON(object)
            XCTAssertEqual(json0, json2)
        } catch {
            XCTFail("Failed to parse JSON object fron rawValue <\(error)>")
        }
    }
    
    func testEquatable() {
        XCTAssertNotEqual(JSON("32.1234567890"), JSON(32.1234567890))
        let veryLargeNumber: UInt64 = 9876543210987654321
        XCTAssertNotEqual(JSON("9876543210987654321"), JSON(NSNumber(value: veryLargeNumber)))
        XCTAssertNotEqual(JSON("9876543210987654321.12345678901234567890"), JSON(9876543210987654321.12345678901234567890))
        XCTAssertEqual(JSON("😊"), JSON("😊"))
        XCTAssertNotEqual(JSON("😱"), JSON("😁"))
        XCTAssertEqual(JSON([123, 321, 456]), JSON([123, 321, 456]))
        XCTAssertNotEqual(JSON([123, 321, 456]), JSON(123456789))
        XCTAssertNotEqual(JSON([123, 321, 456]), JSON("string"))
        XCTAssertNotEqual(JSON(["1": 123, "2": 321, "3": 456]), JSON("string"))
        XCTAssertEqual(JSON(["1": 123, "2": 321, "3": 456]), JSON(["2": 321, "1": 123, "3": 456]))
        XCTAssertEqual(JSON(NSNull()), JSON(NSNull()))
        XCTAssertNotEqual(JSON(NSNull()), JSON(123))
    }
    
    func testJSONDoesProduceValidWithCorrectKeyPath() {

        guard let json = try? JSON(data: self.testData) else {
            XCTFail("Unable to parse testData")
            return
        }

        let tweets = json
        let tweets_array = json.array
        let tweets_1 = json[1]
        _ = tweets_1[1]
        let tweets_1_user_name = tweets_1["user"]["name"]
        let tweets_1_user_name_string = tweets_1["user"]["name"].string
        XCTAssertFalse(tweets.isNull)
        XCTAssert(tweets_array != nil)
        XCTAssertFalse(tweets_1.isNull)
        XCTAssertEqual(tweets_1_user_name, JSON("Raffi Krikorian"))
        XCTAssertEqual(tweets_1_user_name_string!, "Raffi Krikorian")

        let tweets_1_coordinates = tweets_1["coordinates"]
        let tweets_1_coordinates_coordinates = tweets_1_coordinates["coordinates"]
        let tweets_1_coordinates_coordinates_point_0_double = tweets_1_coordinates_coordinates[0].double
        let tweets_1_coordinates_coordinates_point_1_float = tweets_1_coordinates_coordinates[1].float
        let new_tweets_1_coordinates_coordinates = JSON([-122.25831, 37.871609] as NSArray)
        XCTAssertEqual(tweets_1_coordinates_coordinates, new_tweets_1_coordinates_coordinates)
        XCTAssertEqual(tweets_1_coordinates_coordinates_point_0_double!, -122.25831)
        XCTAssertTrue(tweets_1_coordinates_coordinates_point_1_float! == 37.871609)
        let tweets_1_coordinates_coordinates_point_0_string = tweets_1_coordinates_coordinates[0].stringValue
        let tweets_1_coordinates_coordinates_point_1_string = tweets_1_coordinates_coordinates[1].stringValue
        XCTAssertEqual(tweets_1_coordinates_coordinates_point_0_string, "-122.25831")
        XCTAssertEqual(tweets_1_coordinates_coordinates_point_1_string, "37.871609")
        let tweets_1_coordinates_coordinates_point_0 = tweets_1_coordinates_coordinates[0]
        let tweets_1_coordinates_coordinates_point_1 = tweets_1_coordinates_coordinates[1]
        XCTAssertEqual(tweets_1_coordinates_coordinates_point_0, JSON(-122.25831))
        XCTAssertEqual(tweets_1_coordinates_coordinates_point_1, JSON(37.871609))

        let created_at = json[0]["created_at"].string
        let id_str = json[0]["id_str"].string
        let favorited = json[0]["favorited"].bool
        let id = json[0]["id"].int64
        let in_reply_to_user_id_str = json[0]["in_reply_to_user_id_str"]
        XCTAssertEqual(created_at!, "Tue Aug 28 21:16:23 +0000 2012")
        XCTAssertEqual(id_str!, "240558470661799936")
        XCTAssertFalse(favorited!)
        XCTAssertEqual(id!, 240558470661799936)
        XCTAssertTrue(in_reply_to_user_id_str.isNull)

        let user = json[0]["user"]
        let user_name = user["name"].string
        XCTAssert(user_name == "OAuth Dancer")

        let user_dictionary = json[0]["user"].dictionary
        let user_dictionary_name = user_dictionary?["name"]?.string
        XCTAssert(user_dictionary_name == "OAuth Dancer")
    }

    func testJSONNumberCompare() {
        XCTAssertEqual(JSON(12376352.123321), JSON(12376352.123321))
        XCTAssertGreaterThan(JSON(20.211), JSON(20.112))
        XCTAssertGreaterThanOrEqual(JSON(30.211), JSON(20.112))
        XCTAssertGreaterThanOrEqual(JSON(65232), JSON(65232))
        XCTAssertLessThan(JSON(-82320.211), JSON(20.112))
        XCTAssertLessThanOrEqual(JSON(-320.211), JSON(123.1))
        XCTAssertLessThanOrEqual(JSON(-8763), JSON(-8763))

        XCTAssertEqual(JSON(12376352.123321), JSON(12376352.123321))
        XCTAssertGreaterThan(JSON(20.211), JSON(20.112))
        XCTAssertGreaterThanOrEqual(JSON(30.211), JSON(20.112))
        XCTAssertGreaterThanOrEqual(JSON(65232), JSON(65232))
        XCTAssertLessThan(JSON(-82320.211), JSON(20.112))
        XCTAssertLessThanOrEqual(JSON(-320.211), JSON(123.1))
        XCTAssertLessThanOrEqual(JSON(-8763), JSON(-8763))
    }

    func testNumberConvertToString() {
        XCTAssertEqual(JSON(true).stringValue, "true")
        XCTAssertEqual(JSON(999.9823).stringValue, "999.9823")
        XCTAssertEqual(JSON("hello").numberValue.stringValue, "0")
        XCTAssertEqual(JSON(NSNull()).numberValue.stringValue, "0")
        XCTAssertEqual(JSON(["a", "b", "c", "d"]).numberValue.stringValue, "0")
        XCTAssertEqual(JSON(["a": "b", "c": "d"]).numberValue.stringValue, "0")
    }
}
