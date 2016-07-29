//
//  API.swift
//  SwiftHelpSet
//
//  Created by Luca D'Alberti on 7/15/16.
//  Copyright © 2016 dalu93. All rights reserved.
//

import Foundation

public protocol APIModule {
    
    associatedtype RequestType
    
    var baseAPIURL: String { get }
    func load<Object,Error>(resource: Resource<Object>, completion: Completion<Object, Error> -> ()) -> RequestType
}