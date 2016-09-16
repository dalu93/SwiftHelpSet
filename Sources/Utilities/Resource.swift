//
//  Resource.swift
//  SwiftHelpSet
//
//  Created by Luca D'Alberti on 7/15/16.
//  Copyright © 2016 dalu93. All rights reserved.
//

import Foundation

/**
 Enum containing all the supported HTTP methods
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
 *  The `HTTPHeader` struct contains the needed informations to describe
 *  completely an HTTP header field
 */
public struct HTTPHeader {
    
    /// The name of the HTTP header field
    public let name: String
    
    /// The value of the HTTP header field
    public let value: String
}

// MARK: - DictionaryConvertible
extension HTTPHeader: DictionaryConvertible {
    public func toDictionary() -> [String : String]? {
        return [
            name : value
        ]
    }
}

// MARK: - Prefilled HTTPHeaders
public extension HTTPHeader {
    static func HeaderWith(contentType: String) -> HTTPHeader {
        return HTTPHeader(
            name: "Content-Type",
            value: contentType
        )
    }
    
    static var JSONContentType: HTTPHeader {
        return HTTPHeader.HeaderWith(contentType: "application/json")
    }
}


/**
 *  The `Parameter` struct contains the needed informations to descibe
 *  a request parameter. It can be query parameter or body parameter
 */
public struct Parameter {
    
    /// The parameter name
    public let field: String
    
    /// The parameter value
    public let value: AnyObject
}

// MARK: - DictionaryConvertible
extension Parameter: DictionaryConvertible {
    public func toDictionary() -> [String : AnyObject]? {
        return [
            field : value
        ]
    }
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
    fileprivate let _parameters : [Parameter]?
    
    /// The headers
    fileprivate let _headers : [HTTPHeader]?
}

// MARK: - Computed properties
public extension Endpoint {
    
    /// The encoded parameters, ready for the use
    public var parameters: [String : AnyObject]? {
        
        guard let parameters = _parameters else { return nil }
        
        var encParameters: [String : AnyObject] = [:]
        parameters.forEach {
            guard let paramDict = $0.toDictionary() else { return }
            encParameters += paramDict
        }
        
        return encParameters
    }
    
    /// The encoded headers, ready for the use
    public var headers: [String : String]? {
        guard let headers = _headers else { return nil }
        
        var encHeaders: [String : String] = [:]
        headers.forEach {
            guard let headerDict = $0.toDictionary() else { return }
            encHeaders += headerDict
        }
        
        return encHeaders
    }
}

/**
 *  The `Resource` struct contains the information about how to retrieve a 
 *  specific resource and how to parse it from a JSON response
 */
public struct Resource<A> {
    
    /// The endpont to reach
    public let endpoint : Endpoint
    
    /// A closure that indicates how to convert the response in a generic object
    public let parseJSON : (AnyObject) -> A?
}
