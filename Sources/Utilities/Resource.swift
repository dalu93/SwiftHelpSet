//
//  Resource.swift
//  SwiftHelpSet
//
//  Created by Luca D'Alberti on 7/15/16.
//  Copyright © 2016 dalu93. All rights reserved.
//

import Foundation

/**
 Enum containing all the possible HTTP methods
 */
public enum HTTPMethod : String {
    
    case GET
    case POST
    case PUT
    case DELETE
    case OPTIONS
    case HEAD
    case PATCH
    case TRACE
    case CONNECT
    case ERROR
}

/**
 *  The `Endpoint` struct contains all the info regarding
 *  the endpoint you are trying to reach
 */
public struct Endpoint {
    
    /// The path
    public let path : String
    
    /// The HTTP method
    public let method : HTTPMethod
    
    /// The parameters
    public let parameters : [String : AnyObject]?
    
    /// The headers
    public let headers : [String : String]?
}

/**
 *  The `Resource` struct contains the information about how to retrieve a 
 *  specific resource and how to parse it from a JSON response
 */
public struct Resource<A> {
    
    /// The endpont to reach
    public let endpoint : Endpoint
    
    /// A closure that indicates how to convert the response in a generic object
    public let parseJSON : AnyObject -> A?
}