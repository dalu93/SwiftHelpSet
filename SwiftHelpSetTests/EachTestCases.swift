//
//  EachTestCases.swift
//  SwiftHelpSet
//
//  Created by Luca D'Alberti on 9/8/16.
//  Copyright © 2016 dalu93. All rights reserved.
//

import XCTest
@testable import SwiftHelpSet

class EachTestCases: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testEachSimple() {
        let expectation = expectationWithDescription("Timer waiting")
        
        Each(1).seconds.perform {
            expectation.fulfill()
            return true
        }
        
        waitForExpectationsWithTimeout(1.1) { error in
            
            guard let error = error else { return }
            print(error)
        }
    }
    
    func testEachStopInClosure() {
        let expectation = expectationWithDescription("Timer waiting")
        
        let timer = Each(1).seconds.perform() {
            expectation.fulfill()
            return true
        }
        
        waitForExpectationsWithTimeout(1.1) { error in
            guard timer.isStopped else {
                XCTFail("The timer is not stopped even if the closure returns true")
                return
            }
            
            guard let error = error else { return }
            print(error)
        }
    }
    
    func testEachStopAndStartAgain() {
        let expectation = expectationWithDescription("Timer waiting")
        
        let timer = Each(1).seconds.perform() {
            expectation.fulfill()
            return true
        }
        
        timer.stop()
        timer.restart()
        
        waitForExpectationsWithTimeout(1.2) { error in
            guard let error = error else { return }
            print(error)
        }
    }
}
