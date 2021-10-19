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
        case let (.bool(lhs), .bool(rhs)):
            return lhs == rhs
        case let (.string(lhs), .string(rhs)):
            return lhs == rhs
        case let (.number(lhs), .number(rhs)):
            return lhs == rhs
        case let (.array(lhs), .array(rhs)):
            return lhs == rhs
        case let (.dictionary(lhs), .dictionary(rhs)):
            return lhs == rhs
        default:
            return false
        }
    }
    
    public static func <(lhs: JSON, rhs: JSON) -> Bool {
        switch (lhs, rhs) {
        case let (.string(lhs), .string(rhs)):
            return lhs < rhs
        case let (.number(lhs), .number(rhs)):
            return lhs.compare(rhs) == .orderedAscending
        default:
            return false
        }
    }
    
    public static func <=(lhs: JSON, rhs: JSON) -> Bool {
        switch (lhs, rhs) {
        case (.null, .null):
            return true
        case let (.bool(lhs), .bool(rhs)):
            return lhs == rhs
        case let (.string(lhs), .string(rhs)):
            return lhs <= rhs
        case let (.number(lhs), .number(rhs)):
            return lhs.compare(rhs) != .orderedDescending
        case let (.array(lhs), .array(rhs)):
            return lhs == rhs
        case let (.dictionary(lhs), .dictionary(rhs)):
            return lhs == rhs
        default:
            return false
        }
    }
    
    public static func >(lhs: JSON, rhs: JSON) -> Bool {
        switch (lhs, rhs) {
        case let (.string(lhs), .string(rhs)):
            return lhs > rhs
        case let (.number(lhs), .number(rhs)):
            return lhs.compare(rhs) == .orderedDescending
        default:
            return false
        }
    }
    
    public static func >=(lhs: JSON, rhs: JSON) -> Bool {
        switch (lhs, rhs) {
        case (.null, .null):
            return true
        case let (.bool(lhs), .bool(rhs)):
            return lhs == rhs
        case let (.string(lhs), .string(rhs)):
            return lhs >= rhs
        case let (.number(lhs), .number(rhs)):
            return lhs.compare(rhs) != .orderedAscending
        case let (.array(lhs), .array(rhs)):
            return lhs == rhs
        case let (.dictionary(lhs), .dictionary(rhs)):
            return lhs == rhs
        default:
            return false
        }
    }
    
}
