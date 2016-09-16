//
//  Form.swift
//  SwiftHelpSet
//
//  Created by Luca D'Alberti on 7/15/16.
//  Copyright © 2016 dalu93. All rights reserved.
//

import Foundation

public typealias FormValueValidationClosure = (AnyObject) -> Bool

/**
 *  The protocol identifies a Form structure which is validable.
 *
 *  Please provide a complete set of rules for the properties.
 *  Each rule key should be EQUAL to the associated property name
 */
public protocol Form {
    func isValid() -> NSError?
    var rules: [String : FormValueValidationClosure] { get }
}

// MARK: - Generic implementation
public extension Form {
    public func isValid() -> NSError? {
        
        // Creates the enumerator
        let childrenEnumerator = Mirror(reflecting: self).children.enumerated()
        
        // Enumerats the properties
        for (_, property) in childrenEnumerator {
            // If there is a rule-closure associated ok, otherwise crash
            guard
                let propertyLabel = property.label,
                let closure = rules[propertyLabel] else { fatalError("The rule for property \(property.label!) isn't defined") }
            
            // Check if the property is valid
            let isValid = closure(property.value as AnyObject)
            
            // If the property it's not valid
            if !isValid {
                // Return the error
                return .propertyNotRespectRule(property: propertyLabel)
            }
        }
        
        return nil
    }
}

// MARK: - NSError utility
private extension NSError {
    static func propertyNotRespectRule(property: String) -> NSError {
        return NSError(
            domain: "FormValidation",
            code: -1,
            userInfo: [
                NSLocalizedDescriptionKey : "The property \(property) doesn't respect its rule"
            ]
        )
    }
}
