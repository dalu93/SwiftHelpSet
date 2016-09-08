//
//  ConnectionStatus.swift
//  SwiftHelpSet
//
//  Created by Luca D'Alberti on 7/15/16.
//  Copyright © 2016 dalu93. All rights reserved.
//

import Foundation

/**
 The enum describes the connection status with backend.
 
 - notStarted: The connection is not started yet
 - inProgress: The connection is in progress. The associated value is a generic
                `Request`
 - completed:  The connection is completed. See `Completion` to know what the associated value
 
 - SeeAlso: `Completion` enum
 */
public enum ConnectionStatus<Request, Value, Error: ErrorType> {
    
    case notStarted
    case inProgress(Request)
    case completed(Completion<Value,Error>)
    
    /// The associated request, if the status is `inProgress`, otherwise `nil`
    public var request: Request? {
        switch self {
        case .inProgress(let request):  return request
        default:                        return nil
        }
    }
    
    /// The associated value if the connection was completed with success, otherwise `nil`
    public var value: Value? {
        
        switch self {
        case .completed(let completion):
            switch completion {
            case .success(let value):   return value
            case .failed(_):            return nil
            }
        default: return nil
        }
    }
    
    /// The associated error if the connection was completed with error, otherwise `nil`
    public var error: Error? {
        switch self {
        case .completed(let completion):
            switch completion {
                case .success(_):       return nil
            case .failed(let error):    return error
            }
        default: return nil
        }
    }
}