//
//  JSON+Comparable.swift
//  JSON
//
//  Created by Nero on 2020-02-20.
//

import Foundation

extension JSON: Comparable {

  public static func ==(lhs: JSON, rhs: JSON) -> Bool {
    switch (lhs, rhs) {
    case (.null, .null):
      return true
    case (.bool(let lhs), .bool(let rhs)):
      return lhs == rhs
    case (.string(let lhs), .string(let rhs)):
      return lhs == rhs
    case (.number(let lhs), .number(let rhs)):
      return lhs == rhs
    case (.array(let lhs), .array(let rhs)):
      return lhs == rhs
    case (.dictionary(let lhs), .dictionary(let rhs)):
      return lhs == rhs
    default:
      return false
    }
  }

  public static func <(lhs: JSON, rhs: JSON) -> Bool {
    switch (lhs, rhs) {
    case (.string(let lhs), .string(let rhs)):
      return lhs < rhs
    case (.number(let lhs), .number(let rhs)):
      return lhs.compare(rhs) == .orderedAscending
    default:
      return false
    }
  }

  public static func <=(lhs: JSON, rhs: JSON) -> Bool {
    switch (lhs, rhs) {
    case (.null, .null):
      return true
    case (.bool(let lhs), .bool(let rhs)):
      return lhs == rhs
    case (.string(let lhs), .string(let rhs)):
      return lhs <= rhs
    case (.number(let lhs), .number(let rhs)):
      return lhs.compare(rhs) != .orderedDescending
    case (.array(let lhs), .array(let rhs)):
      return lhs == rhs
    case (.dictionary(let lhs), .dictionary(let rhs)):
      return lhs == rhs
    default:
      return false
    }
  }

  public static func >(lhs: JSON, rhs: JSON) -> Bool {
    switch (lhs, rhs) {
    case (.string(let lhs), .string(let rhs)):
      return lhs > rhs
    case (.number(let lhs), .number(let rhs)):
      return lhs.compare(rhs) == .orderedDescending
    default:
      return false
    }
  }

  public static func >=(lhs: JSON, rhs: JSON) -> Bool {
    switch (lhs, rhs) {
    case (.null, .null):
      return true
    case (.bool(let lhs), .bool(let rhs)):
      return lhs == rhs
    case (.string(let lhs), .string(let rhs)):
      return lhs >= rhs
    case (.number(let lhs), .number(let rhs)):
      return lhs.compare(rhs) != .orderedAscending
    case (.array(let lhs), .array(let rhs)):
      return lhs == rhs
    case (.dictionary(let lhs), .dictionary(let rhs)):
      return lhs == rhs
    default:
      return false
    }
  }

}
