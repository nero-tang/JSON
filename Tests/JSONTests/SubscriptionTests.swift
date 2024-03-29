//
//  SubscriptionTests.swift
//  JSONTests
//
//  Created by Nero on 2020-02-21.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
@testable import JSON

class SubscriptionTests: XCTestCase {

  func testNonLiteralIndex() {
    let json: JSON = [
      "array": [0],
      "dictionary": [
        "a": "b",
      ],
    ]

    let keyA = 0
    let keyB = "a"

    XCTAssertEqual(json["array", keyA].intValue, 0)
    XCTAssertEqual(json["dictionary", keyB].stringValue, "b")
  }

  func testArrayAllNumber() {
    var json: JSON = [1, 2.0, 3.3, 123456789, 987654321.123456789]
    XCTAssertTrue(json == [1, 2.0, 3.3, 123456789, 987654321.123456789])
    XCTAssertTrue(json[0] == 1)
    XCTAssertEqual(json[1].double!, 2.0)
    XCTAssertTrue(json[2].floatValue == 3.3)
    XCTAssertEqual(json[3].int!, 123456789)
    XCTAssertEqual(json[4].doubleValue, 987654321.123456789)

    json[0] = 1.9
    json[1] = 2.899
    json[2] = 3.567
    json[3] = 0.999
    json[4] = 98732

    XCTAssertTrue(json[0] == 1.9)
    XCTAssertEqual(json[1].doubleValue, 2.899)
    XCTAssertTrue(json[2] == 3.567)
    XCTAssertTrue(json[3].float! == 0.999)
    XCTAssertTrue(json[4].intValue == 98732)
  }

  func testArrayAllBool() {
    var json: JSON = [true, false, false, true, true]
    XCTAssertTrue(json == [true, false, false, true, true])
    XCTAssertTrue(json[0] == true)
    XCTAssertTrue(json[1] == false)
    XCTAssertTrue(json[2] == false)
    XCTAssertTrue(json[3] == true)
    XCTAssertTrue(json[4] == true)

    json[0] = false
    json[4] = true
    XCTAssertTrue(json[0] == false)
    XCTAssertTrue(json[4] == true)
  }

  func testArrayAllString() {
    var json = JSON(rawValue: ["aoo", "bpp", "zoo"] as NSArray)!
    XCTAssertTrue(json == ["aoo", "bpp", "zoo"])
    XCTAssertTrue(json[0] == "aoo")
    XCTAssertTrue(json[1] == "bpp")
    XCTAssertTrue(json[2] == "zoo")

    json[1] = "update"
    XCTAssertTrue(json[0] == "aoo")
    XCTAssertTrue(json[1] == "update")
    XCTAssertTrue(json[2] == "zoo")
  }

  func testArrayWithNull() {
    var json = JSON(rawValue: ["aoo", "bpp", NSNull(), "zoo"] as NSArray)!
    XCTAssertTrue(json[0] == "aoo")
    XCTAssertTrue(json[1] == "bpp")
    XCTAssertNil(json[2].string)
    XCTAssertNotNil(json[2].null)
    XCTAssertTrue(json[3] == "zoo")

    json[2] = "update"
    json[3] = JSON(NSNull())
    XCTAssertTrue(json[0] == "aoo")
    XCTAssertTrue(json[1] == "bpp")
    XCTAssertTrue(json[2] == "update")
    XCTAssertNil(json[3].string)
    XCTAssertTrue(json[3].isNull)
  }

  func testArrayAllDictionary() {
    let json: JSON = [["1": 1, "2": 2], ["a": "A", "b": "B"], ["null": nil]]
    XCTAssertTrue(json[0] == ["1": 1, "2": 2])
    XCTAssertEqual(json[1].dictionary!, ["a": "A", "b": "B"])
    XCTAssertEqual(json[2], JSON(["null": NSNull()]))
    XCTAssertTrue(json[0]["1"] == 1)
    XCTAssertTrue(json[0]["2"] == 2)
    XCTAssertEqual(json[1]["a"], JSON(rawValue: "A")!)
    XCTAssertEqual(json[1]["b"], JSON("B"))
    XCTAssertNotNil(json[2]["null"].null)
    XCTAssertNotNil(json[2, "null"].null)
    let keys: [JSONIndexType] = [1, "a"]
    XCTAssertEqual(json[keys], JSON(rawValue: "A")!)
  }

  func testDictionaryAllNumber() {
    var json: JSON = ["double": 1.11111, "int": 987654321]
    XCTAssertEqual(json["double"].double!, 1.11111)
    XCTAssertTrue(json["int"] == 987654321)

    json["double"] = 2.2222
    json["int"] = 123456789
    json["add"] = 7890
    XCTAssertTrue(json["double"] == 2.2222)
    XCTAssertEqual(json["int"].doubleValue, 123456789.0)
    XCTAssertEqual(json["add"].intValue, 7890)
  }

  func testDictionaryAllBool() {
    var json: JSON = ["t": true, "f": false, "false": false, "tr": true, "true": true, "yes": true, "1": true]
    XCTAssertTrue(json["1"] == true)
    XCTAssertTrue(json["yes"] == true)
    XCTAssertTrue(json["t"] == true)
    XCTAssertTrue(json["f"] == false)
    XCTAssertTrue(json["false"] == false)
    XCTAssertTrue(json["tr"] == true)
    XCTAssertTrue(json["true"] == true)

    json["f"] = true
    json["tr"] = false
    XCTAssertTrue(json["f"] == true)
    XCTAssertTrue(json["tr"] == JSON(false))
  }

  func testDictionaryAllString() {
    var json = JSON(rawValue: ["a": "aoo", "bb": "bpp", "z": "zoo"] as NSDictionary)!
    XCTAssertTrue(json["a"] == "aoo")
    XCTAssertEqual(json["bb"], JSON("bpp"))
    XCTAssertTrue(json["z"] == "zoo")

    json["bb"] = "update"
    XCTAssertTrue(json["a"] == "aoo")
    XCTAssertTrue(json["bb"] == "update")
    XCTAssertTrue(json["z"] == "zoo")
  }

  func testDictionaryWithNull() {
    var json = JSON(rawValue: ["a": "aoo", "bb": "bpp", "null": NSNull(), "z": "zoo"] as NSDictionary)!
    XCTAssertTrue(json["a"] == "aoo")
    XCTAssertEqual(json["bb"], JSON("bpp"))
    XCTAssertEqual(json["null"], JSON(NSNull()))
    XCTAssertTrue(json["z"] == "zoo")

    json["null"] = "update"
    XCTAssertTrue(json["a"] == "aoo")
    XCTAssertTrue(json["null"] == "update")
    XCTAssertTrue(json["z"] == "zoo")
  }

  func testDictionaryAllArray() {
    //Swift bug: [1, 2.01,3.09] is convert to [1, 2, 3] (Array<Int>)
    let json = JSON ([
      [NSNumber(value: 1), NSNumber(value: 2.123456), NSNumber(value: 123456789)],
      ["aa", "bbb", "cccc"],
      [true, "766", NSNull(), 655231.9823],
    ] as NSArray)
    XCTAssertTrue(json[0] == [1, 2.123456, 123456789])
    XCTAssertEqual(json[0][1].double!, 2.123456)
    XCTAssertTrue(json[0][2] == 123456789)
    XCTAssertTrue(json[1][0] == "aa")
    XCTAssertTrue(json[1] == ["aa", "bbb", "cccc"])
    XCTAssertTrue(json[2][0] == true)
    XCTAssertTrue(json[2][1] == "766")
    XCTAssertTrue(json[[2, 1]] == "766")
    XCTAssertEqual(json[2][2], JSON(NSNull()))
    XCTAssertEqual(json[2, 2], JSON(NSNull()))
    XCTAssertEqual(json[2][3], JSON(655231.9823))
    XCTAssertEqual(json[2, 3], JSON(655231.9823))
    XCTAssertEqual(json[[2, 3]], JSON(655231.9823))
  }

  func testOutOfBounds() {
    let json = JSON ([
      [NSNumber(value: 1), NSNumber(value: 2.123456), NSNumber(value: 123456789)],
      ["aa", "bbb", "cccc"],
      [true, "766", NSNull(), 655231.9823],
    ] as NSArray)
    XCTAssertEqual(json[9], JSON.null)
    XCTAssertEqual(json[9][8], JSON.null)
  }

  func testErrorWrongType() {
    let json = JSON(12345)
    XCTAssertEqual(json[9], JSON.null)
    XCTAssertEqual(json["name"], JSON.null)
  }

  func testErrorNotExist() {
    let json: JSON = ["name": "NAME", "age": 15]
    XCTAssertEqual(json["Type"], JSON.null)
  }

  func testMultilevelGetter() {
    let json: JSON = [[[[["one": 1]]]]]
    XCTAssertEqual(json[[0, 0, 0, 0, "one"]].int!, 1)
    XCTAssertEqual(json[0, 0, 0, 0, "one"].int!, 1)
    XCTAssertEqual(json[0][0][0][0]["one"].int!, 1)
  }

  func testMultilevelSetter1() {
    var json: JSON = [[[[["num": 1]]]]]
    json[0, 0, 0, 0, "num"] = 2
    XCTAssertEqual(json[[0, 0, 0, 0, "num"]].intValue, 2)
    json[0, 0, 0, 0, "num"] = JSON.null
    XCTAssertTrue(json[0, 0, 0, 0, "num"].isNull)
    json[0, 0, 0, 0, "num"] = 100.009
    XCTAssertEqual(json[0][0][0][0]["num"].doubleValue, 100.009)
    json[[0, 0, 0, 0]] = ["name": "Jack"]
    XCTAssertEqual(json[0, 0, 0, 0, "name"].stringValue, "Jack")
    XCTAssertEqual(json[0][0][0][0]["name"].stringValue, "Jack")
    XCTAssertEqual(json[[0, 0, 0, 0, "name"]].stringValue, "Jack")
    json[[0, 0, 0, 0, "name"]].string = "Mike"
    XCTAssertEqual(json[0, 0, 0, 0, "name"].stringValue, "Mike")
    let path: [JSONIndexType] = [0, 0, 0, 0, "name"]
    json[path].string = "Jim"
    XCTAssertEqual(json[path].stringValue, "Jim")
  }

  func testMultilevelSetter2() {
    var json: JSON =
      ["user": [
        "id": 987654,
        "info": ["name": "jack", "email": "jack@gmail.com"],
        "feeds": [98833, 23443, 213239, 23232],
      ]]
    json["user", "info", "name"] = "jim"
    XCTAssertEqual(json["user", "id"], 987654)
    XCTAssertEqual(json["user", "info", "name"], "jim")
    XCTAssertEqual(json["user", "info", "email"], "jack@gmail.com")
    XCTAssertEqual(json["user", "feeds"], [98833, 23443, 213239, 23232])
    json["user", "info", "email"] = "jim@hotmail.com"
    XCTAssertEqual(json["user", "id"], 987654)
    XCTAssertEqual(json["user", "info", "name"], "jim")
    XCTAssertEqual(json["user", "info", "email"], "jim@hotmail.com")
    XCTAssertEqual(json["user", "feeds"], [98833, 23443, 213239, 23232])
    json["user", "info"] = ["name": "tom", "email": "tom@qq.com"]
    XCTAssertEqual(json["user", "id"], 987654)
    XCTAssertEqual(json["user", "info", "name"], "tom")
    XCTAssertEqual(json["user", "info", "email"], "tom@qq.com")
    XCTAssertEqual(json["user", "feeds"], [98833, 23443, 213239, 23232])
    json["user", "feeds"] = [77323, 2313, 4545, 323]
    XCTAssertEqual(json["user", "id"], 987654)
    XCTAssertEqual(json["user", "info", "name"], "tom")
    XCTAssertEqual(json["user", "info", "email"], "tom@qq.com")
    XCTAssertEqual(json["user", "feeds"], [77323, 2313, 4545, 323])
  }

}
