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

func +=<K,V>(inout left: [K:V], right: [K:V]) {
    for (key, value) in right {
        left[key] = value
    }
}