//
//  Bindable.swift
//  SwiftHelpSet
//
//  Created by Luca D'Alberti on 8/3/16.
//  Copyright © 2016 dalu93. All rights reserved.
//

import Foundation

/// The `Bindable` class creates a bridge between the user and the value. In this
/// way the user can bind a listener whenever the value changes.
/// - Note: Trigger is always called on main thread
public class Bindable<T> {
    
    // MARK: - Private
    // MARK: Properties
    public typealias ListenerClosure = (T) -> ()
    fileprivate var listener: ListenerClosure?
    
    // MARK: - Public interface
    // MARK: Properties
    
    /// The value. It can be set manually and read
    public var value: T {
        didSet {
            fire()
        }
    }
    
    // MARK: Lifecycle
    
    public init(value: T) {
        self.value = value
    }
    
    // MARK: Methods
    /**
     Binds a listener so it's called whenever the `value` changes.
     
     - Note: Only one listener at time is supported
     
     - parameter listener: A closure that takes the value `T` as argument
     */
    public func bind(_ listener: @escaping ListenerClosure) {
        self.listener = listener
    }
    
    /**
     Binds a listener so it's called whenever the `value` changes. It even calls
     the listener immediately.
     
     - Note: Only one listener at time is supported
     
     - parameter listener: A closure that takes the value `T` as argument
     */
    func bindAndFire(listener: @escaping ListenerClosure) {
        self.bind(listener)
        self.fire()
    }
}

// MARK: - Firing helpers
private extension Bindable {
    
    func fire() {
        DispatchQueue.main.async {
            self.listener?(self.value)
        }
    }
}
