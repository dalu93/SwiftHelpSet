//
//  IntExtensionsTestCases.swift
//  SwiftHelpSet
//
//  Created by Luca D'Alberti on 8/10/16.
//  Copyright © 2016 dalu93. All rights reserved.
//

import XCTest
@testable import SwiftHelpSet

class IntExtensionsTestCases: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testIsInRangeCorrect() {
        let inRangeNumber = 4
        let range = 0...5
        XCTAssert(inRangeNumber.isInRange(range) == true, "\(inRangeNumber) is contained in \(range). It cannot return false")
    }
    
    func testIsInRangeWrong() {
        let notInRangeNumber = -1
        let range = 0...5
        XCTAssert(notInRangeNumber.isInRange(range) == false, "\(notInRangeNumber) is not contained in \(range). It cannot return true")
    }
    
    func testIsInRangeLimit() {
        let startNumber = 0
        let finalNumber = 5
        let range = startNumber...finalNumber
        XCTAssert((startNumber.isInRange(range) && finalNumber.isInRange(range)), "Both \(startNumber) and \(finalNumber) are contained in \(range). It cannot return false")
    }
}
