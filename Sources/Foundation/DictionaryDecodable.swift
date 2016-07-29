//
//  DictionaryDecodable.swift
//  SwiftHelpSet
//
//  Created by Luca D'Alberti on 7/15/16.
//  Copyright © 2016 dalu93. All rights reserved.
//

import Foundation

public protocol DictionaryDecodable {
    associatedtype ObjectType
    static func from(dictionary dictionary: [String : AnyObject]) -> ObjectType?
}

// MARK: - DictionaryDecodable in NSData
extension NSData: DictionaryDecodable {
    
    static public func from(dictionary dictionary: [String : AnyObject]) -> NSData? {
        return NSKeyedArchiver.archivedDataWithRootObject(dictionary)
    }
}