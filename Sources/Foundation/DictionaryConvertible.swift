//
//  DictionaryConvertible.swift
//  SwiftHelpSet
//
//  Created by Luca D'Alberti on 7/14/16.
//  Copyright © 2016 dalu93. All rights reserved.
//

import Foundation

public protocol DictionaryConvertible {
    
    associatedtype ValueType
    func toDictionary() -> [String : ValueType]?
}

// MARK: - NSData
extension Data: DictionaryConvertible {
    public func toDictionary() -> [String: AnyObject]? {
        
        let serialized = try? JSONSerialization.jsonObject(with: self, options: .allowFragments)
        return serialized as? [String : AnyObject]
    }
}
