//
//  Localizable.swift
//  SwiftHelpSet
//
//  Created by Luca D'Alberti on 7/14/16.
//  Copyright © 2016 dalu93. All rights reserved.
//

import Foundation

/**
 *  Describes an element that could be localized.
 *
 *  This means that every object conforming to this protocol has to be available
 *  in all the languages the application will support.
 */
public protocol Localizable {
    associatedtype LocalizableType
    var localized: LocalizableType { get }
}

// MARK: - NSDateFormatter
extension DateFormatter: Localizable {
    public var localized: DateFormatter {
        self.locale = Locale.current
        return self
    }
}
