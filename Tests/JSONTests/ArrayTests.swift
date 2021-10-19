//
//  ArrayTests.swift
//  JSONTests
//
//  Created by Nero on 2020-02-21.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
@testable import JSON

class ArrayTests: TestCase {
    
    let array = ["1", "2", "a", "b", "c"]

    func testGetter() {
        let json = JSON(array)
        XCTAssertEqual(array, json.array?.map { $0.stringValue })
    }

    func testSetter() {
        var json = JSON(array)
        json.array = [1, 2, 3, 4]
        XCTAssertEqual([1, 2, 3, 4], json.array?.map { $0.intValue })
    }
    
}
