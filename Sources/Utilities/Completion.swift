//
//  Completion.swift
//  SwiftHelpSet
//
//  Created by Luca D'Alberti on 7/15/16.
//  Copyright © 2016 dalu93. All rights reserved.
//

import Foundation

public enum Completion<Value> {
    case success(Value)
    case failed(NSError)
    
    var isSuccess: Bool {
        if case .success(_) = self { return true } else { return false }
    }
    
    var isFailed: Bool { return !isSuccess }
    
    var value: Value? {
        switch self {
        case .success(let value):   return value
        case .failed(_):            return nil
        }
    }
    
    var error: NSError? {
        switch self {
        case .success(_):           return nil
        case .failed(let error):    return error
        }
    }
}
