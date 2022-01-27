//
//  RepresentationTests.swift
//  JSONTests
//
//  Created by Nero on 2020-02-21.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
@testable import JSON

class RepresentationTests: XCTestCase {

  func testRawData() {
    let json: JSON = ["somekey": "some string value"]
    let expectedRawData = "{\"somekey\":\"some string value\"}".data(using: .utf8)
    do {
      let data: Data = try json.dataRepresentation()
      XCTAssertEqual(expectedRawData, data)
    } catch _ {}
  }

  func testArray() {
    let json: JSON = [1, "2", 3.12, nil, true, ["name": "Jack"]]
    let data: Data?
    do {
      data = try json.dataRepresentation()
    } catch _ {
      data = nil
    }
    XCTAssertNotNil(data)

    let jsonFromData = try? JSON(data: data!)
    XCTAssertEqual(json, jsonFromData)

    XCTAssertNoThrow(try json.stringRepresentation())
  }

  func testDictionary() {
    let json: JSON = ["number": 111111.23456789, "name": "Jack", "list": [1, 2, 3, 4], "bool": false, "null": nil]
    let data: Data?
    do {
      data = try json.dataRepresentation()
    } catch _ {
      data = nil
    }
    XCTAssertNotNil(data)

    let jsonFromData = try? JSON(data: data!)
    XCTAssertEqual(json, jsonFromData)

    XCTAssertNoThrow(try json.stringRepresentation())
  }

  func testString() {
    let json: JSON = "I'm a json"

    let string = try? json.stringRepresentation(options: .fragmentsAllowed)

    XCTAssertEqual(string, "\"I'm a json\"")

    let jsonFromString = try? JSON(string: string!, options: .fragmentsAllowed)

    XCTAssertEqual(json, jsonFromString)
  }

  func testNumber() {
    let json: JSON = 123456789.123

    let string = try? json.stringRepresentation(options: .fragmentsAllowed)

    XCTAssertEqual(string, "123456789.123")

    let jsonFromString = try? JSON(string: string!, options: .fragmentsAllowed)

    XCTAssertEqual(json, jsonFromString)
  }

  func testBool() {
    let json: JSON = true

    let string = try? json.stringRepresentation(options: .fragmentsAllowed)

    XCTAssertEqual(string, "true")

    let jsonFromString = try? JSON(string: string!, options: .fragmentsAllowed)

    XCTAssertEqual(json, jsonFromString)
  }

  func testNull() {
    let json = JSON.null

    let string = try? json.stringRepresentation(options: .fragmentsAllowed)

    XCTAssertEqual(string, "null")

    let jsonFromString = try? JSON(string: string!, options: .fragmentsAllowed)

    XCTAssertEqual(json, jsonFromString)
  }

  func testNestedJSON() {
    let inner: JSON = ["name": "john doe"]
    let json: JSON = ["level": 1337, "user": inner]
    let data: Data?
    do {
      data = try json.dataRepresentation()
    } catch _ {
      data = nil
    }
    let string = try? json.stringRepresentation()
    XCTAssertNotNil(data)
    XCTAssertNotNil(string)
  }

}
