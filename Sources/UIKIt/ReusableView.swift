//
//  ReusableView.swift
//  SwiftHelpSet
//
//  Created by Luca D'Alberti on 7/14/16.
//  Copyright © 2016 dalu93. All rights reserved.
//

import Foundation

// MARK: - Protocols definition
/**
 *  Describes an initializable class from UINib
 */
public protocol NibConvertible {
    static var nibName: String { get }
}

/**
 *  Identifier for class
 */
public protocol IdentifierConvertible {
    
    static var identifier: String { get }
}

/**
 *  A reusable view
 */
public protocol ReusableView: NibConvertible, IdentifierConvertible {}

extension NibConvertible {
    static var nibName: String { return String(Self) }
}

extension IdentifierConvertible {
    static var identifier: String { return String(Self) }
}

// MARK: - Nib instantiation
extension NibConvertible {
    static var nib: UINib { return UINib.nibFrom(string: Self.nibName) }
}

// MARK: - UINib extension
import UIKit
extension UINib {
    
    static func nibFrom(string string: String, bundle: NSBundle? = nil) -> UINib {
        return UINib(
            nibName: string,
            bundle: bundle
        )
    }
}
