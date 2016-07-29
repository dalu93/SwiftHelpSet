//
//  ArrayExtensions.swift
//  SwiftHelpSet
//
//  Created by Luca D'Alberti on 7/14/16.
//  Copyright © 2016 dalu93. All rights reserved.
//

import Foundation

extension Array {
    
    /**
     Get the element at the specific index
     
     If the `index` is out of bounds, the method will return `nil`
     
     - parameter index: The index to get
     
     - returns: The `Element` at `index` position. If the `index` is out of bounds,
                the method will return `nil`
     */
    public func get(at index: Int) -> Element? {
        if count > index { return self[index] }
        return nil
    }
}