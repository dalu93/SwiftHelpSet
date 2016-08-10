//
//  NSDateExtensionsTestCases.swift
//  SwiftHelpSet
//
//  Created by Luca D'Alberti on 8/10/16.
//  Copyright © 2016 dalu93. All rights reserved.
//

import XCTest
@testable import SwiftHelpSet

class NSDateExtensionsTestCases: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testEqualOperatorWithTwoEqualDates() {
        let firstDate = NSDate()
        let secondDate = firstDate
        
        XCTAssert(firstDate == secondDate, "The two dates are equal. It should return true")
    }
    
    func testEqualOperatorWithDifferentDates() {
        let firstDate = NSDate()
        let secondDate = firstDate.dateByAddingTimeInterval(1)
        
        XCTAssert(firstDate != secondDate, "The two dates are differents. It should return true")
    }
    
    func testLessThanOtherDate() {
        let firstDate = NSDate()
        let secondDate = firstDate.dateByAddingTimeInterval(-1)
        
        XCTAssert(secondDate < firstDate, "Second date is less than the first date.")
    }
    
    func testGreaterThanOtherDate() {
        let firstDate = NSDate()
        let secondDate = firstDate.dateByAddingTimeInterval(1)
        
        XCTAssert(secondDate > firstDate, "Second date is greater than the first date.")
    }
}
