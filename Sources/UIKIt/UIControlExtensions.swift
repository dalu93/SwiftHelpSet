//
//  UIControlExtensions.swift
//  SwiftHelpSet
//
//  Created by Luca D'Alberti on 8/9/16.
//  Copyright © 2016 dalu93. All rights reserved.
//

import UIKit

// MARK: - Helper class for storing closures
class ClosureWrapper {
    let closure: () -> ()
    
    init(closure: @escaping () -> ()) {
        self.closure = closure
    }
}

private var UIControlObserver: StaticString = "UIControlObserver"

// MARK: - Observer implementation
public extension UIControl {
    
    private var closureWrapper: ClosureWrapper? {
        get {
            return objc_getAssociatedObject(self, &UIControlObserver) as? ClosureWrapper
        }
        
        set {
            objc_setAssociatedObject(
                self,
                &UIControlObserver,
                newValue,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
    
    /**
     Observes the `UIControl` instance for the specific `eventType`. When it happens,
     it executes the closure.
     
     - Note: There could be only an observer at time
     
     - parameter eventType: The event type
     - parameter closure:   The closure to execute
     */
    public func bind(_ eventType: UIControlEvents, closure: @escaping ()->()) {
        self.closureWrapper = ClosureWrapper(closure: closure)
        self.addTarget(self, action: .Triggered, for: eventType)
    }
    
    @objc fileprivate func triggered(sender: AnyObject) {
        self.closureWrapper?.closure()
    }
}

// MARK: - Selector helper
private extension Selector {
    static let Triggered = #selector(UIControl.triggered(sender:))
}
