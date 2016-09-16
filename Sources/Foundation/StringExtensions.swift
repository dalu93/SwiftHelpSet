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
public extension String {
    
    /// It tells if the `String` instance is a valid email or not
    public var isEmail: Bool {
        
        let trimmed = trimmingCharacters(in: NSCharacterSet.whitespaces)
        
        do {
            let regex = try NSRegularExpression(
                pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$",
                options: .caseInsensitive
            )
            
            return regex.firstMatch(
                in: trimmed,
                options: NSRegularExpression.MatchingOptions(rawValue: 0),
                range: NSMakeRange(0, trimmed.characters.count)) != nil
        } catch {
            return false
        }
    }
    
    /// It tells if the `String` instance is completely empty (by trimming the spaces)
    public var isBlank: Bool {
        get {
            let trimmed = replacingOccurrences(of: " ", with: "")
            return trimmed.isEmpty
        }
    }
    
    /// It tells if the `String` instance is a valid phone number or not
    public var isPhoneNumber: Bool {
        
        let character = NSCharacterSet(
            charactersIn: "+0123456789"
        ).inverted
        
        let inputString: [String] = self.components(separatedBy: character)
        
        let filtered = inputString.joined()
        
        let trimmed = replacingOccurrences(of: " ", with: "")
        
        return  trimmed == filtered
        
    }
    
    /// Length of the string
    public var length: Int {
        return self.characters.count
    }
}
