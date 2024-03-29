//
//  CodableTests.swift
//  JSON_Example
//
//  Created by Nero on 2020-02-20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
@testable import JSON

// MARK: - CodableTests

class CodableTests: TestCase {

  func testNullCodable() {
    let json = JSON(NSNull())

    do {
      // Please note that JSONEncoder/Decoder does not support top-level json object
      // Workaround by wrapping the JSON into an array
      let data = try JSONEncoder().encode([json])
      let jsonFromData = try JSONDecoder().decode([JSON].self, from: data).first

      XCTAssertEqual(jsonFromData, json)
    } catch {
      XCTFail("\(error)")
    }
  }

  func testArrayCodable() {
    let jsonString = """
      [1,"false", ["A", 4.3231],"3",true]
      """
    var data = jsonString.data(using: .utf8)!
    let json = try! JSONDecoder().decode(JSON.self, from: data)
    XCTAssertEqual(json.arrayValue.first?.int, 1)
    XCTAssertEqual(json[1].bool, nil)
    XCTAssertEqual(json[1].string, "false")
    XCTAssertEqual(json[3].string, "3")
    XCTAssertEqual(json[2][1].double!, 4.3231)
    XCTAssertEqual(json.arrayValue[0].bool, nil)
    XCTAssertEqual(json.array!.last!.bool, true)
    let jsonList = try! JSONDecoder().decode([JSON].self, from: data)
    XCTAssertEqual(jsonList.first?.int, 1)
    XCTAssertEqual(jsonList.last!.bool, true)
    data = try! JSONEncoder().encode(json)
    let list = try! JSONSerialization.jsonObject(with: data, options: []) as! [Any]
    XCTAssertEqual(list[0] as! Int, 1)
    XCTAssertEqual((list[2] as! [Any])[1] as! NSNumber, 4.3231)
  }

  func testDictionaryCodable() {
    let dictionary: [String: Any] = [
      "number": 9823.212,
      "name": "NAME",
      "list": [1234, 4.21223256],
      "object": ["sub_number": 877.2323, "sub_name": "sub_name"],
      "bool": true,
    ]
    var data = try! JSONSerialization.data(withJSONObject: dictionary, options: [])
    let json = try! JSONDecoder().decode(JSON.self, from: data)
    XCTAssertNotNil(json.dictionary)
    XCTAssertEqual(json["number"].float, 9823.212)
    XCTAssertEqual(json["list"].rawValue is [NSNumber], true)
    XCTAssertEqual(json["object"]["sub_number"].float, 877.2323)
    XCTAssertEqual(json["bool"].bool, true)
    let jsonDict = try! JSONDecoder().decode([String: JSON].self, from: data)
    XCTAssertEqual(jsonDict["number"]?.int, 9823)
    XCTAssertEqual(jsonDict["object"]?["sub_name"], "sub_name")
    data = try! JSONEncoder().encode(json)
    var encoderDict = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
    XCTAssertEqual(encoderDict["list"] as! [NSNumber], [1234, 4.21223256])
    XCTAssertEqual(encoderDict["bool"] as! Bool, true)
    data = try! JSONEncoder().encode(jsonDict)
    encoderDict = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
    XCTAssertEqual(encoderDict["name"] as! String, dictionary["name"] as! String)
    XCTAssertEqual((encoderDict["object"] as! [String: Any])["sub_number"] as! NSNumber, 877.2323)
  }

  func testCodableModel() {
    let dictionary: [String: Any] = [
      "number": 9823.212,
      "name": "NAME",
      "list": [1234, 4.21223256],
      "object": ["sub_number": 877.2323, "sub_name": "sub_name"],
      "bool": true,
    ]
    let data = try! JSONSerialization.data(withJSONObject: dictionary, options: [])
    let model = try! JSONDecoder().decode(CodableModel.self, from: data)
    XCTAssertEqual(model.subName, "sub_name")
  }
}

// MARK: - CodableModel

private struct CodableModel: Codable {
  let name: String
  let number: Double
  let bool: Bool
  let list: [Double]
  private let object: JSON
  var subName: String? {
    object["sub_name"].string
  }
}
