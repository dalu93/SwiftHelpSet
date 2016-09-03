//
//  ConnectionStatus.swift
//  SwiftHelpSet
//
//  Created by Luca D'Alberti on 7/15/16.
//  Copyright © 2016 dalu93. All rights reserved.
//

import Foundation

public enum ConnectionStatus<Request, Value> {
    
    case notStarted
    case inProgress(Request)
    case completed(Completion<Value>)
    
    public var request: Request? {
        switch self {
        case .inProgress(let request):  return request
        default:                        return nil
        }
    }
    
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
    
    public var error: NSError? {
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
