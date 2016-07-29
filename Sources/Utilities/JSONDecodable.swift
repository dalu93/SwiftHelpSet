//
//  JSONDecodable.swift
//  SwiftHelpSet
//
//  Created by Luca D'Alberti on 7/19/16.
//  Copyright © 2016 dalu93. All rights reserved.
//

import Foundation

/**
 *  This protocol identifies objects that are initializable using a `[String : AnyObject]`
 *  dictionary
 */
public protocol JSONDecodable: DictionaryDecodable {}