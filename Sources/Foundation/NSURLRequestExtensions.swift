//
//  NSURLRequestExtensions.swift
//  SwiftHelpSet
//
//  Created by Luca D'Alberti on 8/19/16.
//  Copyright © 2016 dalu93. All rights reserved.
//

import Foundation

extension URLRequest {
    public static func request(with URLString: String) -> URLRequest? {
        guard let url = URL(string: URLString) else { return nil }
        
        return URLRequest(url: url)
    }
}
