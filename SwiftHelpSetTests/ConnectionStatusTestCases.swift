//
//  ConnectionStatusTestCases.swift
//  SwiftHelpSet
//
//  Created by Luca D'Alberti on 8/29/16.
//  Copyright © 2016 dalu93. All rights reserved.
//

import XCTest
@testable import SwiftHelpSet

class ConnectionStatusTestCases: XCTestCase {
    
    var status: ConnectionStatus<Array<Int>, Int> = .notStarted
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
        status = .notStarted
    }
    
    func testRequest() {
        status = .inProgress([])
        
        XCTAssert(status.request != nil, "The request is invalid")
    }
    
    func testSuccess() {
        let value = 1
        
        status = .completed(.success(value))
        
        XCTAssert(status.value != nil && status.value == value, "The value is invalid")
    }
    
    func testFailed() {
        let error = NSError(domain: "TestCase", code: -1, userInfo: nil)
        
        status = .completed(.failed(error))
        
        XCTAssert(status.error != nil && status.error == error, "The error is invalid")
    }
    
    func testNotStarted() {
        XCTAssert(status.error == nil && status.request == nil && status.value == nil, ".notStarted cannot have an associated value")
    }
}
