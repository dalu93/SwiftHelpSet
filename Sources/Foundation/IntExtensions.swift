//
//  IntExtensions.swift
//  SwiftHelpSet
//
//  Created by Luca D'Alberti on 8/8/16.
//  Copyright © 2016 dalu93. All rights reserved.
//

import Foundation

extension Int {
    
    /**
     Tells you wheter the Int instance is contained in the range
     
     - parameter range: Range of `Int`
     
     - returns: Returns `true` if the number is contained in the range, otherwise `false`
     */
    func isInRange(range: Range<Int>) -> Bool {
        return range.contains(self)
    }
}