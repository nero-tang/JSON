//
//  JSON+RawRepresentable.swift
//  JSON
//
//  Created by Nero on 2020-02-19.
//

import Foundation

extension JSON: RawRepresentable {
    
    public typealias RawValue = Any
    
    public var rawValue: Any {
        switch self {
        case .null:
            return NSNull()
        case .bool(let bool):
            return bool
        case .string(let string):
            return string
        case .number(let number):
            return number
        case .array(let array):
            return array.map { $0.rawValue }
        case .dictionary(let dictionary):
            return dictionary.mapValues { $0.rawValue }
        }
    }
    
    public init?(rawValue: Any) {
        switch rawValue {
        case let object as JSONConvertible:
            self = object.json
        case let object as [Any?]:
            var array = [JSON](repeating: .null, count: object.count)
            
            for (index, element) in object.enumerated() {
                if let json = JSON(rawValue: element ?? NSNull()) {
                    array[index] = json
                } else {
                    return nil
                }
            }
            self = .array(array)
        case let object as [String: Any?]:
            var dictionary = [String: JSON](minimumCapacity: object.count)
            
            for (key, value) in object {
                if let json = JSON(rawValue: value ?? NSNull()) {
                    dictionary[key] = json
                } else {
                    return nil
                }
            }
            self = .dictionary(dictionary)
        default:
            return nil
        }
    }
    
}
