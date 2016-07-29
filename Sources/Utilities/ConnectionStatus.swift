//
//  ConnectionStatus.swift
//  SwiftHelpSet
//
//  Created by Luca D'Alberti on 7/15/16.
//  Copyright © 2016 dalu93. All rights reserved.
//

import Foundation

public enum ConnectionStatus<Request, Value, Error> {
    
    case notStarted
    case inProgress(Request)
    case succeeded(Value)
    case failed(Error)
    
    public var request: Request? {
        switch self {
        case .inProgress(let request):  return request
        default:                        return nil
        }
    }
    
    public var value: Value? {
        switch self {
        case .succeeded(let value):     return value
        default:                        return nil
        }
    }
    
    public var error: Error? {
        switch self {
        case .failed(let error):        return error
        default:                        return nil
        }
    }
}