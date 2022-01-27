//
//  JSON+Codable.swift
//  JSON
//
//  Created by Nero on 2020-02-19.
//

import Foundation

extension JSON: Codable {

  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()

    if container.decodeNil() {
      self = .null
    } else if let bool = try? container.decode(Bool.self) {
      self = .bool(bool)
    } else if let string = try? container.decode(String.self) {
      self = .string(string)
    } else if let int64 = try? container.decode(Int64.self) {
      self = .number(.init(value: int64))
    } else if let uint64 = try? container.decode(UInt64.self) {
      self = .number(.init(value: uint64))
    } else if let double = try? container.decode(Double.self) {
      self = .number(.init(value: double))
    } else if let array = try? container.decode([JSON].self) {
      self = .array(array)
    } else if let dictionary = try? container.decode([String: JSON].self) {
      self = .dictionary(dictionary)
    } else {
      throw DecodingError.dataCorruptedError(in: container, debugDescription: "Unsupported JSON element")
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()

    switch self {
    case .null:
      try container.encodeNil()
    case .bool(let bool):
      try container.encode(bool)
    case .string(let string):
      try container.encode(string)
    case .number(let number):
      let objCType = String(cString: number.objCType)
      switch objCType {
      case "c":
        try container.encode(number.int8Value)
      case "C":
        try container.encode(number.uint8Value)
      case "s":
        try container.encode(number.int16Value)
      case "S":
        try container.encode(number.uint16Value)
      case "i":
        try container.encode(number.int32Value)
      case "I":
        try container.encode(number.uint32Value)
      case "l":
        try container.encode(number.intValue)
      case "L":
        try container.encode(number.uintValue)
      case "q":
        try container.encode(number.int64Value)
      case "Q":
        try container.encode(number.uint64Value)
      case "f":
        try container.encode(number.floatValue)
      case "d":
        try container.encode(number.doubleValue)
      default:
        let context = EncodingError.Context(
          codingPath: [],
          debugDescription: "Unsupported objCType <\(objCType)> for number <\(number)>"
        )
        throw EncodingError.invalidValue(number, context)
      }
    case .array(let array):
      try container.encode(array)
    case .dictionary(let dictionary):
      try container.encode(dictionary)
    }
  }
}
