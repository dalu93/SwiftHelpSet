//
//  CompletionTestCases.swift
//  SwiftHelpSet
//
//  Created by Luca D'Alberti on 8/29/16.
//  Copyright © 2016 dalu93. All rights reserved.
//

import XCTest
@testable import SwiftHelpSet

class CompletionTestCases: XCTestCase {
    
    var status: Completion<Int> = .success(0)
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSuccess() {
        let value = 1
        status = .success(value)
        
        XCTAssert(status.isSuccess == true && status.isFailed == false && status.value == value, "Current success status is invalid")
    }
    
    func testFailed() {
        let error = NSError(domain: "TestCompletion", code: -1, userInfo: nil)
        status = .failed(error)
        
        XCTAssert(status.isFailed == true && status.isSuccess == false && status.error == error, "Current failed status is invalid")
    }
}
