//
//  NSURLRequestExtensionsTestCases.swift
//  SwiftHelpSet
//
//  Created by Luca D'Alberti on 8/29/16.
//  Copyright © 2016 dalu93. All rights reserved.
//

import XCTest
@testable import SwiftHelpSet

class NSURLRequestExtensionsTestCases: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testCreateNSURLRequestFromCorrectString() {
        let urlString = "http://www.google.com"
        
        let request = NSURLRequest.request(with: urlString)
        
        XCTAssert(request != nil, "The request should be valid since the urlString is a valid URL")
    }
    
    func testCreateNSURLRequestFromIncorrectString() {
        let incorrectUrlString = "hel lo"
        
        let request = NSURLRequest.request(with: incorrectUrlString)
        
        XCTAssert(request == nil, "The request cannot be a valid one. The urlString is invalid")
    }
}
