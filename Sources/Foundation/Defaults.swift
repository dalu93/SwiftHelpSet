//
//  Defaults.swift
//  SwiftHelpSet
//
//  Created by Luca D'Alberti on 9/27/16.
//  Copyright © 2016 dalu93. All rights reserved.
//

import Foundation

// MARK: - DefaultKey declaration
public struct DefaultKey {}

// MARK: - DefaultKey.Name support
public extension DefaultKey {
    public struct Name: RawRepresentable, Equatable {
        public var rawValue: String
        
        public init?(rawValue: String) {
            self.rawValue = rawValue
        }
    }
}

// MARK: - DefaultKey.Name Equatable conformance
/// Compares two `DefaultKey.Name` instances
///
/// - parameter lhs: First instance
/// - parameter rhs: Second instance
///
/// - returns: `true` if their `rawValue` are the same, otherwise `false`
public func ==(lhs: DefaultKey.Name, rhs: DefaultKey.Name) -> Bool {
    return lhs.rawValue == rhs.rawValue
}

// MARK: - UserDefaults helpers
public extension UserDefaults {

    /// Get a value stored in the `standard` `UserDefaults`
    ///
    /// - parameter key: The key
    ///
    /// - returns: The stored value, if there is, otherwise `nil`
    public func get<T>(for key: DefaultKey.Name) -> T? {
        return UserDefaults.standard.value(forKey: key.rawValue) as? T
    }
    
    /// Get a value stored in the `standard` `UserDefaults` or a default value
    ///
    /// - parameter key:          The key
    /// - parameter defaultValue: A default value
    ///
    /// - returns: The stored value, if there is, otherwise the default one
    public func get<T>(for key: DefaultKey.Name, or defaultValue: T) -> T {
        return (UserDefaults.standard.value(forKey: key.rawValue) as? T) ?? defaultValue
    }
    
    /// Set a new value in the `standard` `UserDefaults`.
    ///
    /// If the new value is `nil`, the value will be removed from the storage
    ///
    /// - parameter value: The value. It can be `nil`
    /// - parameter key:   The key
    public func set(_ value: Any?, for key: DefaultKey.Name) {
        if let value = value {
            UserDefaults.standard.setValue(value, forKey: key.rawValue)
            UserDefaults.standard.synchronize()
        } else {
            UserDefaults.standard.removeValue(for: key)
        }
    }
    
    /// Remove a value in the `standard` `UserDefaults` for the specific key
    ///
    /// - parameter key: The key
    public func removeValue(for key: DefaultKey.Name) {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
        UserDefaults.standard.synchronize()
    }
}

// MARK: - Defaults declaration
/// The Defaults enum provides a simple and faster way to access the `UserDefaults`
///
/// - standard: Access to the `standard` `UserDefaults`
/// - custom:   Access to a custom `UserDefaults`
public enum Defaults<ValueType> {
    
    case standard
    case custom(UserDefaults)
    
    fileprivate var _userDefaults: UserDefaults {
        switch self {
        case .standard:             return UserDefaults.standard
        case .custom(let defaults): return defaults
        }
    }
    
    /// Get the value stored or a default value
    ///
    /// - parameter key:   The key
    /// - parameter value: The default value
    ///
    /// - returns: The value stored, otherwise the default one
    public subscript(key: DefaultKey.Name, or value: ValueType) -> ValueType {
        get {
            return _userDefaults.get(for: key, or: value)
        }
    }
    
    /// Get and set values from the `UserDefaults`
    ///
    /// - parameter key: The key
    ///
    /// - returns: The value stored or the new Defaults instance
    public subscript(key: DefaultKey.Name) -> ValueType? {
        get {
            return _userDefaults.get(for: key)
        }
        
        set {
            _userDefaults.set(newValue, for: key)
        }
    }
}
