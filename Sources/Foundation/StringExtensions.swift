//
//  StringExtensions.swift
//  SwiftHelpSet
//
//  Created by Luca D'Alberti on 7/14/16.
//  Copyright © 2016 dalu93. All rights reserved.
//

import Foundation

// MARK: - Localizable
extension String: Localizable {
    
    /// The `localized` version of the `String` instance
    public var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}


// MARK: - String Validation
extension String {
    
    /// It tells if the `String` instance is a valid email or not
    public var isEmail: Bool {
        do {
            let regex = try NSRegularExpression(
                pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$",
                options: .CaseInsensitive
            )
            
            return regex.firstMatchInString(
                self,
                options: NSMatchingOptions(rawValue: 0),
                range: NSMakeRange(0, self.characters.count)) != nil
        } catch {
            return false
        }
    }
    
    /// It tells if the `String` instance is completely empty (by trimming the spaces)
    public var isBlank: Bool {
        get {
            let trimmed = stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            return trimmed.isEmpty
        }
    }
    
    /// It tells if the `String` instance is a valid phone number or not
    public var isPhoneNumber: Bool {
        
        let character = NSCharacterSet(
            charactersInString: "+0123456789"
        ).invertedSet
        
        let inputString: NSArray = self.componentsSeparatedByCharactersInSet(character)
        
        let filtered = inputString.componentsJoinedByString("")
        
        return  self == filtered
        
    }
}