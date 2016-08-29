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
    
    private var listener: ((T) -> ())?
    
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
     
     - parameter listener: A closure that takes the value `T` as argument. The closure
                           is always called on the main thread
     */
    public func bind(listener: (T) -> ()) {
        self.listener = listener
    }
    
    /**
     Binds a listener so it's called whenever the `value` changes. It even calls
     the listener immediately.
     
     - Note: Only one listener at time is supported
     
     - parameter listener: A closure that takes the value `T` as argument. The closure
                           is always called on the main thread
     */
    func bindAndFire(listener: (T) -> ()) {
        self.bind(listener)
        self.fire()
    }
}

// MARK: - Firing helpers
private extension Bindable {
    
    func fire() {
        dispatch_async(dispatch_get_main_queue()) {
            self.listener?(self.value)
        }
    }
}