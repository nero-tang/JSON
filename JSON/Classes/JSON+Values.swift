//
//  JSON+Values.swift
//  JSON
//
//  Created by Nero on 2020-02-19.
//

import Foundation

extension JSON {
    
    public var isNull: Bool {
        switch self {
        case .null:
            return true
        default:
            return false
        }
    }
    
    public var bool: Bool? {
        get {
            switch self {
            case .bool(let bool):
                return bool
            default:
                return nil
            }
        }
        set {
            if let newValue = newValue {
                self = .bool(newValue)
            } else {
                self = .null
            }
        }
    }
    
    public var boolValue: Bool {
        get {
            switch self {
            case .bool(let bool):
                return bool
            default:
                return numberValue.boolValue
            }
        }
        set {
            bool = newValue
        }
    }
    
    public var string: String? {
        get {
            switch self {
            case .string(let string):
                return string
            default:
                return nil
            }
        }
        set {
            if let newValue = newValue {
                self = .string(newValue)
            } else {
                self = .null
            }
        }
    }
    
    public var stringValue: String {
        get {
            switch self {
            case .bool(let bool):
                return String(describing: bool)
            case .string(let string):
                return string
            case .number(let number):
                return number.stringValue
            default:
                return String()
            }
        }
        set {
            string = newValue
        }
    }
    
    public var array: [JSON]? {
        get {
            switch self {
            case .array(let array):
                return array
            default:
                return nil
            }
        }
        set {
            if let newValue = newValue {
                self = .array(newValue)
            } else {
                self = .null
            }
        }
    }
    
    public var arrayValue: [JSON] {
        get {
            return array ?? []
        }
        set {
            array = newValue
        }
    }
    
    public var dictionary: [String: JSON]? {
        get {
            switch self {
            case .dictionary(let dictionary):
                return dictionary
            default:
                return nil
            }
        }
        set {
            if let newValue = newValue {
                self = .dictionary(newValue)
            } else {
                self = .null
            }
        }
    }
    
    public var dictionaryValue: [String: JSON] {
        get {
            return dictionary ?? [:]
        }
        set {
            dictionary = newValue
        }
    }
    
    // MARK: - NSNumber
    
    public var number: NSNumber? {
        get {
            switch self {
            case .number(let number):
                return number
            default:
                return nil
            }
        }
        set {
            if let newValue = newValue {
                self = .number(newValue)
            } else {
                self = .null
            }
        }
    }
    
    public var numberValue: NSNumber {
        get {
            switch self {
            case .bool(let bool):
                return NSNumber(value: bool)
            case .string(let string):
                if let decimal = Decimal(string: string), !decimal.isNaN {
                    return decimal as NSDecimalNumber
                } else {
                    return 0
                }
            case .number(let number):
                return number
            default:
                return 0
            }
        }
        set {
            number = newValue
        }
    }
    
    // MARK: - Integer Numbers
    
    public var int: Int? {
        get {
            return number?.intValue
        }
        set {
            number = newValue.map(NSNumber.init(value: ))
        }
    }
    
    public var intValue: Int {
        get {
            return numberValue.intValue
        }
        set {
            int = newValue
        }
    }
    
    public var int8: Int8? {
        get {
            return number?.int8Value
        }
        set {
            number = newValue.map(NSNumber.init(value: ))
        }
    }
    
    public var int8Value: Int8 {
        get {
            return numberValue.int8Value
        }
        set {
            int8 = newValue
        }
    }
    
    public var int16: Int16? {
        get {
            return number?.int16Value
        }
        set {
            number = newValue.map(NSNumber.init(value: ))
        }
    }
    
    public var int16Value: Int16 {
        get {
            return numberValue.int16Value
        }
        set {
            int16 = newValue
        }
    }
    
    public var int32: Int32? {
        get {
            return number?.int32Value
        }
        set {
            number = newValue.map(NSNumber.init(value: ))
        }
    }
    
    public var int32Value: Int32 {
        get {
            return numberValue.int32Value
        }
        set {
            int32 = newValue
        }
    }
    
    public var int64: Int64? {
        get {
            return number?.int64Value
        }
        set {
            number = newValue.map(NSNumber.init(value: ))
        }
    }
    
    public var int64Value: Int64 {
        get {
            return numberValue.int64Value
        }
        set {
            int64 = newValue
        }
    }
    
    public var uint: UInt? {
        get {
            return number?.uintValue
        }
        set {
            number = newValue.map(NSNumber.init(value: ))
        }
    }
    
    public var uintValue: UInt {
        get {
            return numberValue.uintValue
        }
        set {
            uint = newValue
        }
    }
    
    public var uint8: UInt8? {
        get {
            return number?.uint8Value
        }
        set {
            number = newValue.map(NSNumber.init(value: ))
        }
    }
    
    public var uint8Value: UInt8 {
        get {
            return numberValue.uint8Value
        }
        set {
            uint8 = newValue
        }
    }
    
    public var uint16: UInt16? {
        get {
            return number?.uint16Value
        }
        set {
            number = newValue.map(NSNumber.init(value: ))
        }
    }
    
    public var uint16Value: UInt16 {
        get {
            return numberValue.uint16Value
        }
        set {
            uint16 = newValue
        }
    }
    
    public var uint32: UInt32? {
        get {
            return number?.uint32Value
        }
        set {
            number = newValue.map(NSNumber.init(value: ))
        }
    }
    
    public var uint32Value: UInt32 {
        get {
            return numberValue.uint32Value
        }
        set {
            uint32 = newValue
        }
    }
    
    public var uint64: UInt64? {
        get {
            return number?.uint64Value
        }
        set {
            number = newValue.map(NSNumber.init(value: ))
        }
    }
    
    public var uint64Value: UInt64 {
        get {
            return numberValue.uint64Value
        }
        set {
            uint64 = newValue
        }
    }
    
    // MARK: - Floating-Point Numbers
    
    public var float: Float? {
        get {
            return number?.floatValue
        }
        set {
            number = newValue.map(NSNumber.init(value: ))
        }
    }
    
    public var floatValue: Float {
        get {
            return numberValue.floatValue
        }
        set {
            float = newValue
        }
    }
    
    public var double: Double? {
        get {
            return number?.doubleValue
        }
        set {
            number = newValue.map(NSNumber.init(value: ))
        }
    }
    
    public var doubleValue: Double {
        get {
            return numberValue.doubleValue
        }
        set {
            double = newValue
        }
    }
}
