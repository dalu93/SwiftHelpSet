//
//  ArrayExtensionsTestCases.swift
//  SwiftHelpSet
//
//  Created by Luca D'Alberti on 8/2/16.
//  Copyright © 2016 dalu93. All rights reserved.
//

import XCTest
@testable import SwiftHelpSet

class ArrayExtensionsTestCases: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testGetAtIndexInBounds() {
        let exampleArray: [Int] = [1,2,3]
        XCTAssert(exampleArray.get(at: 0) != nil, "The array has an element at index 0. It can't be nil")
    }
    
    func testGetAtIndexOutOfBounds() {
        let exampleArray: [Int] = [1,2,3]
        
        let indexToRetrieve = 10
        
        XCTAssert(exampleArray.get(at: indexToRetrieve) == nil, "The array hasn't element at index \(indexToRetrieve). The return value has to be nil")
    }
    
    func testRemoveObjectInArray() {
        let objectToRemove = "hello"
        var array = [objectToRemove, "world"]
        
        XCTAssert(array.remove(objectToRemove) == 0, "The index to return should be the item index")
    }
    
    func testRemoveObjectNotInArray() {
        let objectToRemove = "hello"
        var array = ["world"]
        
        XCTAssert(array.remove(objectToRemove) == nil, "The object is not in the array")
    }
    
    func testRemoveObjectItemIsRemoved() {
        let objectToRemove = "hello"
        var array = [objectToRemove, "world"]
        
        _ = array.remove(objectToRemove)
        
        XCTAssert(array.contains(objectToRemove) == false, "The array cannot contain the just removed element")
    }
}
