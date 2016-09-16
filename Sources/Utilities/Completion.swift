//
//  Completion.swift
//  SwiftHelpSet
//
//  Created by Luca D'Alberti on 7/15/16.
//  Copyright © 2016 dalu93. All rights reserved.
//

import Foundation

/**
 The enum describes a completion status.
 
 - success: The operation was completed with success
 - failed:  The operation was completed with error
 */

public enum Completion<Value> {
    case success(Value)
    case failed(NSError)
    
    /// Succeeded or not
    var isSuccess: Bool {
        if case .success(_) = self { return true } else { return false }
    }
    
    
    /// Failed or not
    var isFailed: Bool { return !isSuccess }
    
    /// The associated value if the operation was completed with success
    var value: Value? {
        switch self {
        case .success(let value):   return value
        case .failed(_):            return nil
        }
    }
    
    /// The associated error if the operation was completed with error
    var error: NSError? {
        switch self {
        case .success(_):           return nil
        case .failed(let error):    return error
        }
    }
}
