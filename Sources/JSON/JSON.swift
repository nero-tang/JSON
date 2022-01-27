//
//  JSON.swift
//  JSON
//
//  Created by Nero on 2020-02-19.
//

import Foundation

// MARK: - JSON

@dynamicMemberLookup
public enum JSON {

  case null

  case bool(Bool)

  case string(String)

  case number(NSNumber)

  case array([JSON])

  case dictionary([String: JSON])

  public init(_ object: Any) {
    if let json = JSON(rawValue: object) {
      self = json
    } else {
      self = .null
    }
  }

  public init(data: Data, options: JSONSerialization.ReadingOptions = []) throws {
    let jsonObject = try JSONSerialization.jsonObject(with: data, options: options)
    self = JSON(jsonObject)
  }

  public init(string: String, options: JSONSerialization.ReadingOptions = []) throws {
    self = try JSON(data: string.data(using: .utf8)!, options: options)
  }

  public func dataRepresentation(options: JSONSerialization.WritingOptions = []) throws -> Data {
    try JSONSerialization.data(withJSONObject: rawValue, options: options)
  }

  public func stringRepresentation(options: JSONSerialization.WritingOptions = []) throws -> String {
    let data = try dataRepresentation(options: options)
    return String(data: data, encoding: .utf8)!
  }
}

// MARK: CustomStringConvertible

extension JSON: CustomStringConvertible {

  public var description: String {
    String(describing: rawValue)
  }
}
