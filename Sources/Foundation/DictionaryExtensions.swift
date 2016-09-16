//
//  DictionaryExtensions.swift
//  SwiftHelpSet
//
//  Created by Luca D'Alberti on 8/9/16.
//  Copyright © 2016 dalu93. All rights reserved.
//

import Foundation

public extension Dictionary {
    
    /**
     Creates a new dictionary instance by adding a set of dictionaries
     
     - parameter dictionaries: Set of dictionaries of the same type
     
     - returns: Sum of all the dictionaries
     */
    public static func byAdding<K,V>(dictionaries: [[K:V]]) -> [K:V] {
        var dictionarySum: [K:V] = [:]
        dictionaries.forEach {
            dictionarySum += $0
        }
        
        return dictionarySum
    }
}

/**
 Adds the element of the right dictionary to the left dictionary

 - Note: If a right dictionary's key exists on the left dictionary, the value will be
        overwritten
 - parameter left:  A dictionary
 - parameter right: An another dictionary
 */
public func +=<K,V>(left: inout [K:V], right: [K:V]) {
    for (key, value) in right {
        left[key] = value
    }
}

/**
 Creates a new `Dictionary` instance that is the result of the 
 `lhs += rhs` operation.
 
 - Note:    the `rhs` values have the priority and they will override the `lhs` values
            for the same key.
 
 - parameter lhs: A `Dictionary`
 - parameter rhs: The other `Dictionary`
 
 - returns: A new `Dictionary` instance that is the sum of the two dictionaries
 */
public func +<K,V>(lhs: [K:V], rhs: [K:V]) -> [K:V] {
    var sumDictionary = lhs
    sumDictionary += rhs
    
    return sumDictionary
}
