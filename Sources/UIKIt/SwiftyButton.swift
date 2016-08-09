//
//  SwiftyButton.swift
//  SwiftHelpSet
//
//  Created by Luca D'Alberti on 8/9/16.
//  Copyright © 2016 dalu93. All rights reserved.
//

import UIKit

/// The `SwiftyButton` simplifies your code by enabling a new way to set the
/// target for the `UIControlEvents`
public class SwiftyButton: UIButton {
    
    private var _triggerClosure: ((AnyObject) -> ())?
    
    /**
     Observes the specified `UIControlEvents` and executes the closure whenever it happens
     
     - Note: It can handle only one event per time
     
     - parameter eventType: The event to listen
     - parameter closure:   The closure to execute
     */
    public func observe(eventType: UIControlEvents, closure: (AnyObject) -> ()) {
        self.addTarget(self, action: .Triggered, forControlEvents: eventType)
    }
    
    func triggered(sender: AnyObject) {
        _triggerClosure?(sender)
    }
}

// MARK: - Selector helper
private extension Selector {
    static let Triggered: Selector = #selector(SwiftyButton.triggered(_:))
}
