//
//  JSON+ExpressibleByLiterals.swift
//  JSON
//
//  Created by Nero on 2020-02-19.
//

import Foundation

extension JSON: ExpressibleByNilLiteral {
    
    public init(nilLiteral: ()) {
        self = .null
    }
}

extension JSON: ExpressibleByStringLiteral {
    
    public init(stringLiteral value: String) {
        self = value.json
    }
}

extension JSON: ExpressibleByBooleanLiteral {
    
    public init(booleanLiteral value: Bool) {
        self = value.json
    }
}

extension JSON: ExpressibleByIntegerLiteral {
    
    public init(integerLiteral value: Int) {
        self = value.json
    }
}

extension JSON: ExpressibleByFloatLiteral {
    
    public init(floatLiteral value: Double) {
        self = value.json
    }
}

extension JSON: ExpressibleByArrayLiteral {
    
    public init(arrayLiteral elements: JSON...) {
        self = .array(elements)
    }
}

extension JSON: ExpressibleByDictionaryLiteral {
    
    public init(dictionaryLiteral elements: (String, JSON)...) {
        var dictionary = [String: JSON](minimumCapacity: elements.count)
        for (key, value) in elements {
            dictionary[key] = value
        }
        self = .dictionary(dictionary)
    }
}
