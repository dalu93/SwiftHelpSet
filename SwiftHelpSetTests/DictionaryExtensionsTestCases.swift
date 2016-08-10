//
//  DictionaryExtensionsTestCases.swift
//  SwiftHelpSet
//
//  Created by Luca D'Alberti on 8/10/16.
//  Copyright © 2016 dalu93. All rights reserved.
//

import XCTest
@testable import SwiftHelpSet

class DictionaryExtensionsTestCases: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testDictionaryAdditionWithoutOverwrite() {
        var aDictionary = [
            "field" : 1
        ]
        
        let bDictionary = [
            "field1" : 2
        ]
        
        aDictionary += bDictionary
        
        XCTAssert((aDictionary["field"] != nil && aDictionary["field1"] != nil), "After sum, the aDictionary should contain all the fields")
    }
    
    func testDictionaryAdditionWithOverwrite() {
        var aDictionary = [
            "field" : 1,
            "field1" : 5
        ]
        
        let bDictionary = [
            "field1" : 2
        ]
        
        aDictionary += bDictionary
        
        XCTAssert(aDictionary["field1"] == 2, "The field field1 should have value equal to 2, not to 5, after sum.")
    }
}
