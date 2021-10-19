//
//  Support.swift
//  JSON
//
//  Created by Nero on 2020-02-19.
//

import Foundation

func NSNumberIsBoolean(_ number: NSNumber) -> Bool {
    return number === kCFBooleanTrue || number === kCFBooleanFalse
}
