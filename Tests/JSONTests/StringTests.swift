//
//  StringTests.swift
//  JSONTests
//
//  Created by Nero on 2020-02-21.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
@testable import JSON

class StringTests: XCTestCase {

  func testString() {
    //getter
    var json = JSON("abcdefg hijklmn;opqrst.?+_()")
    XCTAssertEqual(json.string!, "abcdefg hijklmn;opqrst.?+_()")
    XCTAssertEqual(json.stringValue, "abcdefg hijklmn;opqrst.?+_()")

    json.string = "12345?67890.@#"
    XCTAssertEqual(json.string!, "12345?67890.@#")
    XCTAssertEqual(json.stringValue, "12345?67890.@#")
  }

  func testUrl() {
    let json = JSON("http://github.com")
    XCTAssertEqual(URL(string: json.stringValue), URL(string: "http://github.com")!)
  }

  func testBoolWith1() {
    let json = JSON("1")
    XCTAssertTrue(json.boolValue)
  }

  func testUrlPercentEscapes() {
    let emDash = "\\u2014"
    let urlString = "http://example.com/unencoded" + emDash + "string"
    guard let encodedURLString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
      return XCTFail("Couldn't encode URL string \(urlString)")
    }
    let preEscaped = JSON(encodedURLString)
    XCTAssertEqual(URL(string: preEscaped.stringValue), URL(string: encodedURLString)!)
  }

  func testNullToString() {
    let json = JSON.null
    XCTAssertEqual("", json.stringValue)
  }

  func testStringSetter() {
    var json: JSON = [:]
    json.a.string = nil

    XCTAssertEqual(json.a.string, nil)

    json.b.stringValue = "a"
    XCTAssertEqual(json.b.stringValue, "a")
  }
}
