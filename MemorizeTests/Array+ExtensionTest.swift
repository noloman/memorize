//
//  Array+ExtensionTest.swift
//  MemorizeTests
//
//  Created by Manuel Lorenzo (noloman) on 01/06/2021.
//

import Foundation
import XCTest

class ArrayExtensionTest: XCTestCase {
    func testArrayOneAndOnlyIsNotNil() {
        XCTAssertTrue([1].oneAndOnly != nil)
    }
    
    func testArrayOneAndOnlyOfEmptyArrayIsNil() {
        XCTAssertTrue([].oneAndOnly == nil)
    }
}
