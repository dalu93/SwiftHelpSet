//
//  ArrayExtensions.swift
//  SwiftHelpSet
//
//  Created by Luca D'Alberti on 7/14/16.
//  Copyright © 2016 dalu93. All rights reserved.
//

import Foundation

public extension Array {
    
    /**
     Gets the element at the specific index
     
     If the `index` is out of bounds, the method will return `nil`
     
     - parameter index: The index to get
     
     - returns: The `Element` at `index` position. If the `index` is out of bounds,
                the method will return `nil`
     */
    public func get(at index: Int) -> Element? {
        if index.isInRange(0..<count) { return self[index] }
        return nil
    }
    
    /**
     Removes a specific `Equatable` object from the array
     
     - parameter object: Equatable conforming object to delete
     
     - returns: Returns the index of the object in the array if it found it,
                otherwise `nil`
     */
    public mutating func remove<T: Equatable>(_ object: T) -> Int? {
        
        for (idx, stored) in enumerated() {
            guard let stored = stored as? T else { break }
            
            if stored == object {
                remove(at: idx)
                return idx
            }
        }
        
        return nil
    }
}
