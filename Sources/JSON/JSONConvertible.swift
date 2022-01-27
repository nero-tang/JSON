//
//  JSONConvertible.swift
//  JSON
//
//  Created by Nero on 2020-02-19.
//

import Foundation

// MARK: - JSONConvertible

protocol JSONConvertible {

  var json: JSON { get }
}

// MARK: - JSON + JSONConvertible

extension JSON: JSONConvertible {

  var json: JSON {
    self
  }
}

// MARK: - Optional + JSONConvertible

extension Optional: JSONConvertible where Wrapped: JSONConvertible {

  var json: JSON {
    switch self {
    case .some(let wrapped):
      return wrapped.json
    default:
      return .null
    }
  }
}

// MARK: - NSNull + JSONConvertible

extension NSNull: JSONConvertible {

  var json: JSON {
    .null
  }
}

// MARK: - String + JSONConvertible

extension String: JSONConvertible {

  var json: JSON {
    .string(self)
  }
}

// MARK: - NSString + JSONConvertible

extension NSString: JSONConvertible {

  var json: JSON {
    .string(self as String)
  }
}

// MARK: - NSNumber + JSONConvertible

extension NSNumber: JSONConvertible {

  var json: JSON {
    if NSNumberIsBoolean(self) {
      return .bool(boolValue)
    } else {
      return .number(self)
    }
  }
}

// MARK: - Decimal + JSONConvertible

extension Decimal: JSONConvertible {

  var json: JSON {
    .number(self as NSDecimalNumber)
  }
}

// MARK: - Bool + JSONConvertible

extension Bool: JSONConvertible {

  var json: JSON {
    .bool(self)
  }
}

// MARK: - Int + JSONConvertible

extension Int: JSONConvertible {

  var json: JSON {
    .number(.init(value: self))
  }
}

// MARK: - Int8 + JSONConvertible

extension Int8: JSONConvertible {

  var json: JSON {
    .number(.init(value: self))
  }
}

// MARK: - Int16 + JSONConvertible

extension Int16: JSONConvertible {

  var json: JSON {
    .number(.init(value: self))
  }
}

// MARK: - Int32 + JSONConvertible

extension Int32: JSONConvertible {

  var json: JSON {
    .number(.init(value: self))
  }
}

// MARK: - Int64 + JSONConvertible

extension Int64: JSONConvertible {

  var json: JSON {
    .number(.init(value: self))
  }
}

// MARK: - UInt + JSONConvertible

extension UInt: JSONConvertible {

  var json: JSON {
    .number(.init(value: self))
  }
}

// MARK: - UInt8 + JSONConvertible

extension UInt8: JSONConvertible {

  var json: JSON {
    .number(.init(value: self))
  }
}

// MARK: - UInt16 + JSONConvertible

extension UInt16: JSONConvertible {

  var json: JSON {
    .number(.init(value: self))
  }
}

// MARK: - UInt32 + JSONConvertible

extension UInt32: JSONConvertible {

  var json: JSON {
    .number(.init(value: self))
  }
}

// MARK: - UInt64 + JSONConvertible

extension UInt64: JSONConvertible {

  var json: JSON {
    .number(.init(value: self))
  }
}

// MARK: - Float + JSONConvertible

extension Float: JSONConvertible {

  var json: JSON {
    .number(.init(value: self))
  }
}

// MARK: - Double + JSONConvertible

extension Double: JSONConvertible {

  var json: JSON {
    .number(.init(value: self))
  }
}

// MARK: - Array + JSONConvertible

extension Array: JSONConvertible where Element: JSONConvertible {

  var json: JSON {
    .array(map { $0.json })
  }
}

// MARK: - Dictionary + JSONConvertible

extension Dictionary: JSONConvertible where Key == String, Value: JSONConvertible {

  var json: JSON {
    .dictionary(mapValues { $0.json })
  }
}
