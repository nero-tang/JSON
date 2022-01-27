//
//  ExpressibleByLiteralsTests.swift
//  JSONTests
//
//  Created by Nero on 2020-02-21.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
@testable import JSON

class ExpressibleByLiteralsTests: TestCase {

  func testNumber() {
    let json: JSON = 1234567890.876623
    XCTAssertEqual(json.int!, 1234567890)
    XCTAssertEqual(json.intValue, 1234567890)
    XCTAssertEqual(json.double!, 1234567890.876623)
    XCTAssertEqual(json.doubleValue, 1234567890.876623)
    XCTAssertTrue(json.float! == 1234567890.876623)
    XCTAssertTrue(json.floatValue == 1234567890.876623)
  }

  func testBool() {
    let jsonTrue: JSON = true
    XCTAssertEqual(jsonTrue.bool!, true)
    XCTAssertEqual(jsonTrue.boolValue, true)
    let jsonFalse: JSON = false
    XCTAssertEqual(jsonFalse.bool!, false)
    XCTAssertEqual(jsonFalse.boolValue, false)
  }

  func testString() {
    let json: JSON = "abcd efg, HIJK;LMn"
    XCTAssertEqual(json.string!, "abcd efg, HIJK;LMn")
    XCTAssertEqual(json.stringValue, "abcd efg, HIJK;LMn")
  }

  func testNil() {
    let jsonNil_1: JSON = nil
    XCTAssert(jsonNil_1 == JSON.null)
    let jsonNil_2 = JSON(NSNull())
    XCTAssert(jsonNil_2 == JSON.null)
    let jsonNil_3 = JSON([1: 2])
    XCTAssert(jsonNil_3 == JSON.null)
  }

  func testArray() {
    let json: JSON = [1, 2, "4", 5, "6"]
    XCTAssertEqual(json.array!, [1, 2, "4", 5, "6"])
    XCTAssertEqual(json.arrayValue, [1, 2, "4", 5, "6"])
  }

  func testDictionary() {
    let json: JSON = ["1": 2, "2": 2, "three": 3, "list": ["aa", "bb", "dd"]]
    XCTAssertEqual(json.dictionary!, ["1": 2, "2": 2, "three": 3, "list": ["aa", "bb", "dd"]])
    XCTAssertEqual(json.dictionaryValue, ["1": 2, "2": 2, "three": 3, "list": ["aa", "bb", "dd"]])
  }

}
