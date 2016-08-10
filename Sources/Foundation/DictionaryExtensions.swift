//
//  DictionaryExtensions.swift
//  SwiftHelpSet
//
//  Created by Luca D'Alberti on 8/9/16.
//  Copyright © 2016 dalu93. All rights reserved.
//

import Foundation

extension Dictionary {
}

/**
 Adds the element of the right dictionary to the left dictionary

 - Note: If a right dictionary's key exists on the left dictionary, the value will be
        overwritten
 - parameter left:  A dictionary
 - parameter right: An another dictionary
 */
func +=<K,V>(inout left: [K:V], right: [K:V]) {
    for (key, value) in right {
        left[key] = value
    }
}