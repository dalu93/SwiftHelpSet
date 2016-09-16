//
//  ErrorConvertible.swift
//  SwiftHelpSet
//
//  Created by Luca D'Alberti on 7/15/16.
//  Copyright © 2016 dalu93. All rights reserved.
//

import Foundation

public protocol ErrorConvertible {
    func toError() -> Error
}
