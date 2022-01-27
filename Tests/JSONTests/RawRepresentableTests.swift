//
//  RawRepresentableTests.swift
//  JSONTests
//
//  Created by Nero on 2020-02-21.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
@testable import JSON

class RawRepresentableTests: XCTestCase {

  func testNumber() {
    let json = JSON(rawValue: 948394394.347384 as NSNumber)!
    XCTAssertEqual(json.int!, 948394394)
    XCTAssertEqual(json.intValue, 948394394)
    XCTAssertEqual(json.double!, 948394394.347384)
    XCTAssertEqual(json.doubleValue, 948394394.347384)
    XCTAssertEqual(json.float!, 948394394.347384)
    XCTAssertEqual(json.floatValue, 948394394.347384)

    let object: Any = json.rawValue
    if let int = object as? Int {
      XCTAssertEqual(int, 948394394)
    }
    XCTAssertEqual(object as? Double, 948394394.347384)
    if let float = object as? Float {
      XCTAssertEqual(float, 948394394.347384)
    }
    XCTAssertEqual(object as? NSNumber, 948394394.347384)
  }

  func testBool() {
    let jsonTrue = JSON(rawValue: true as NSNumber)!
    XCTAssertEqual(jsonTrue.bool!, true)
    XCTAssertEqual(jsonTrue.boolValue, true)

    let jsonFalse = JSON(rawValue: false)!
    XCTAssertEqual(jsonFalse.bool!, false)
    XCTAssertEqual(jsonFalse.boolValue, false)

    let objectTrue = jsonTrue.rawValue
    XCTAssertEqual(objectTrue as? Bool, true)

    let objectFalse = jsonFalse.rawValue
    XCTAssertEqual(objectFalse as? Bool, false)
  }

  func testString() {
    let string = "The better way to deal with JSON data in Swift."
    if let json = JSON(rawValue: string) {
      XCTAssertEqual(json.string!, string)
      XCTAssertEqual(json.stringValue, string)
      XCTAssertTrue(json.array == nil)
      XCTAssertTrue(json.dictionary == nil)
      XCTAssertEqual(json.rawValue as? String, string)
    } else {
      XCTFail("Should not run into here")
    }

    let object: Any = JSON(rawValue: string)!.rawValue
    XCTAssertEqual(object as? String, string)
  }

  func testNil() {
    if JSON(rawValue: NSObject()) != nil {
      XCTFail("Should not run into here")
    }
  }

  func testArray() {
    let array = [1, 2, "3", 4102, "5632", "abocde", "!@# $%^&*()"] as NSArray
    if let json = JSON(rawValue: array) {
      XCTAssertEqual(json, JSON(array))
    }

    let object: Any = JSON(rawValue: array)!.rawValue
    XCTAssertTrue(array == object as! NSArray)
  }

  func testDictionary() {
    let dictionary = ["1": 2, "2": 2, "three": 3, "list": ["aa", "bb", "dd"]] as NSDictionary
    if let json = JSON(rawValue: dictionary) {
      XCTAssertEqual(json, JSON(dictionary))
    }

    let object: Any = JSON(rawValue: dictionary)!.rawValue
    XCTAssertTrue(dictionary == object as! NSDictionary)
  }
}
