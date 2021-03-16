//
//  JSONConvertible.swift
//  JSON
//
//  Created by Nero on 2020-02-19.
//

import Foundation

protocol JSONConvertible {
    
    var json: JSON { get }
}

extension JSON: JSONConvertible {
    
    var json: JSON {
        return self
    }
}

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

extension NSNull: JSONConvertible {
    
    var json: JSON {
        return .null
    }
}

extension String: JSONConvertible {
    
    var json: JSON {
        return .string(self)
    }
}

extension NSString: JSONConvertible {
    
    var json: JSON {
        return .string(self as String)
    }
}

extension NSNumber: JSONConvertible {
    
    var json: JSON {
        if NSNumberIsBoolean(self) {
            return .bool(boolValue)
        } else {
            return .number(self)
        }
    }
}

extension Decimal: JSONConvertible {
    
    var json: JSON {
        return .number(self as NSDecimalNumber)
    }
}

extension Bool: JSONConvertible {
    
    var json: JSON {
        return .bool(self)
    }
}

extension Int: JSONConvertible {
    
    var json: JSON {
        return .number(.init(value: self))
    }
}

extension Int8: JSONConvertible {
    
    var json: JSON {
        return .number(.init(value: self))
    }
}

extension Int16: JSONConvertible {
    
    var json: JSON {
        return .number(.init(value: self))
    }
}

extension Int32: JSONConvertible {
    
    var json: JSON {
        return .number(.init(value: self))
    }
}

extension Int64: JSONConvertible {
    
    var json: JSON {
        return .number(.init(value: self))
    }
}

extension UInt: JSONConvertible {
    
    var json: JSON {
        return .number(.init(value: self))
    }
}

extension UInt8: JSONConvertible {
    
    var json: JSON {
        return .number(.init(value: self))
    }
}

extension UInt16: JSONConvertible {
    
    var json: JSON {
        return .number(.init(value: self))
    }
}

extension UInt32: JSONConvertible {
    
    var json: JSON {
        return .number(.init(value: self))
    }
}

extension UInt64: JSONConvertible {
    
    var json: JSON {
        return .number(.init(value: self))
    }
}

extension Float: JSONConvertible {
    
    var json: JSON {
        return .number(.init(value: self))
    }
}

extension Double: JSONConvertible {
    
    var json: JSON {
        return .number(.init(value: self))
    }
}

extension Array: JSONConvertible where Element: JSONConvertible {
    
    var json: JSON {
        return .array(map { $0.json })
    }
}

extension Dictionary: JSONConvertible where Key == String, Value: JSONConvertible {
    
    var json: JSON {
        return .dictionary(mapValues { $0.json })
    }
}
