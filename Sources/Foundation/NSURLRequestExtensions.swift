//
//  NSURLRequestExtensions.swift
//  SwiftHelpSet
//
//  Created by Luca D'Alberti on 8/19/16.
//  Copyright © 2016 dalu93. All rights reserved.
//

import Foundation

extension NSURLRequest {
    public static func request(with URLString: String) -> NSURLRequest? {
        guard let url = NSURL(string: URLString) else { return nil }
        
        return NSURLRequest(URL: url)
    }
}