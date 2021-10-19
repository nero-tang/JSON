//
//  DictionaryTests.swift
//  JSONTests
//
//  Created by Nero on 2020-02-21.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
@testable import JSON

class DictionaryTests: TestCase {

     func testGetter() {
           let dictionary = ["number": 9823.212, "name": "NAME", "list": [1234, 4.212], "object": ["sub_number": 877.2323, "sub_name": "sub_name"], "bool": true] as [String: Any]
           let json = JSON(dictionary)
           //dictionary
           XCTAssertEqual((json.dictionary!["number"]!).double!, 9823.212)
           XCTAssertEqual((json.dictionary!["name"]!).string!, "NAME")
           XCTAssertEqual(((json.dictionary!["list"]!).array![0]).int!, 1234)
           XCTAssertEqual(((json.dictionary!["list"]!).array![1]).double!, 4.212)
           XCTAssertEqual((((json.dictionary!["object"]! as JSON).dictionaryValue)["sub_number"]! as JSON).double!, 877.2323)
           XCTAssertTrue(json.dictionary!["null"] == nil)
           //dictionaryValue
           XCTAssertEqual(((((json.dictionaryValue)["object"]! as JSON).dictionaryValue)["sub_name"]! as JSON).string!, "sub_name")
           XCTAssertEqual((json.dictionaryValue["bool"]! as JSON).bool!, true)
           XCTAssertTrue(json.dictionaryValue["null"] == nil)
           XCTAssertTrue(JSON.null.dictionaryValue == [:])
           //dictionaryObject
           XCTAssertTrue(JSON.null.dictionary == nil)
       }

       func testSetter() {
           var json: JSON = ["test": "case"]
           XCTAssertEqual(json.dictionary, ["test": "case"])
           json.dictionary = ["name": "NAME"]
           XCTAssertEqual(json.dictionary, ["name": "NAME"])
       }

}
