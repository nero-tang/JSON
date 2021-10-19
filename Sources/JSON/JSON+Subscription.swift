//
//  JSON+Subscription.swift
//  JSON
//
//  Created by Nero on 2020-02-19.
//

import Foundation

public enum JSONIndex {
    
    case int(Int)
    
    case string(String)
}

public protocol JSONIndexType {
    
    var jsonIndex: JSONIndex { get }
}

extension Int: JSONIndexType {
    
    public var jsonIndex: JSONIndex { .int(self) }
}

extension String: JSONIndexType {
    
    public var jsonIndex: JSONIndex { .string(self) }
}

extension JSON {
    
    private subscript(index: JSONIndex) -> JSON {
        get {
            switch index {
            case .int(let index):
                return self[at: index]
            case .string(let key):
                return self[key: key]
            }
        }
        set {
            switch index {
            case .int(let index):
                self[at: index] = newValue
            case .string(let key):
                self[key: key] = newValue
            }
        }
    }
    
    public subscript(indices: JSONIndexType...) -> JSON {
        get {
            return self[indices]
        }
        set {
            self[indices] = newValue
        }
    }
    
    public subscript(indices: [JSONIndexType]) -> JSON {
        get {
            return indices.reduce(self) { $0[$1.jsonIndex] }
        }
        set {
            if indices.isEmpty {
                self = newValue
            } else {
                var indices = indices
                let firstIndex = indices.removeFirst()
                
                var subJSON = self[firstIndex.jsonIndex]
                subJSON[indices] = newValue
                self[firstIndex.jsonIndex] = subJSON
            }
        }
    }
    
    private subscript(at index: Int) -> JSON {
        get {
            switch self {
            case .array(let array):
                if array.indices.contains(index) {
                    return array[index]
                } else {
                    return .null
                }
            default:
                return .null
            }
        }
        set {
            switch self {
            case .array(var array):
                if array.indices.contains(index) {
                    array[index] = newValue
                    self = .array(array)
                }
            default:
                break
            }
        }
    }
    
    private subscript(key key: String) -> JSON {
        get {
            switch self {
            case .dictionary(let dictionary):
                if let value = dictionary[key] {
                    return value
                } else {
                    return .null
                }
            default:
                return .null
            }
        }
        set {
            switch self {
            case .dictionary(var dictionary):
                dictionary[key] = newValue
                self = .dictionary(dictionary)
            default:
                break
            }
        }
        
    }
    
    public subscript(dynamicMember member: String) -> JSON {
        get {
            return self[key: member]
        }
        set {
            self[key: member] = newValue
        }
    }
}
