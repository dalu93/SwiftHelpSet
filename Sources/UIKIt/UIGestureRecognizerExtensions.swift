//
//  UIGestureRecognizerExtensions.swift
//  SwiftHelpSet
//
//  Created by Luca D'Alberti on 8/19/16.
//  Copyright © 2016 dalu93. All rights reserved.
//

import UIKit

private var _UIGestureRecognizerClosure: StaticString = "UIGestureRecognizerClosure"

public extension UIGestureRecognizer {
    
    fileprivate var closureWrapper: ClosureWrapper? {
        get {
            return objc_getAssociatedObject(self, &_UIGestureRecognizerClosure) as? ClosureWrapper
        }
        
        set {
            objc_setAssociatedObject(
                self,
                &_UIGestureRecognizerClosure,
                newValue,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
    
    func trigger() {
        self.closureWrapper?.closure()
    }
}

public extension UITapGestureRecognizer {
    
    /**
     Creates and returns a gesture recognizer that performs a specific closure instead of a selector
     
     - parameter closure: The closure to execute
     
     - returns: The newly created UIGestureRecognizer subclass
     */
    public static func recognizerPerforms(closure: @escaping () -> ()) -> UITapGestureRecognizer {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(UIGestureRecognizer.trigger))
        recognizer.closureWrapper = ClosureWrapper(closure: closure)
        return recognizer
    }
}

public extension UIPinchGestureRecognizer {
    
    /**
     Creates and returns a gesture recognizer that performs a specific closure instead of a selector
     
     - parameter closure: The closure to execute
     
     - returns: The newly created UIGestureRecognizer subclass
     */
    public static func recognizerPerforms(closure: @escaping () -> ()) -> UIPinchGestureRecognizer {
        let recognizer = UIPinchGestureRecognizer(target: self, action: #selector(UIGestureRecognizer.trigger))
        recognizer.closureWrapper = ClosureWrapper(closure: closure)
        return recognizer
    }
}

public extension UIRotationGestureRecognizer {
    
    /**
     Creates and returns a gesture recognizer that performs a specific closure instead of a selector
     
     - parameter closure: The closure to execute
     
     - returns: The newly created UIGestureRecognizer subclass
     */
    public static func recognizerPerforms(closure: @escaping () -> ()) -> UIRotationGestureRecognizer {
        let recognizer = UIRotationGestureRecognizer(target: self, action: #selector(UIGestureRecognizer.trigger))
        recognizer.closureWrapper = ClosureWrapper(closure: closure)
        return recognizer
    }
}

public extension UISwipeGestureRecognizer {
    
    /**
     Creates and returns a gesture recognizer that performs a specific closure instead of a selector
     
     - parameter closure: The closure to execute
     
     - returns: The newly created UIGestureRecognizer subclass
     */
    public static func recognizerPerforms(closure: @escaping () -> ()) -> UISwipeGestureRecognizer {
        let recognizer = UISwipeGestureRecognizer(target: self, action: #selector(UIGestureRecognizer.trigger))
        recognizer.closureWrapper = ClosureWrapper(closure: closure)
        return recognizer
    }
}

public extension UIPanGestureRecognizer {
    
    /**
     Creates and returns a gesture recognizer that performs a specific closure instead of a selector
     
     - parameter closure: The closure to execute
     
     - returns: The newly created UIGestureRecognizer subclass
     */
    public static func recognizerPerforms<T>(closure: @escaping () -> ()) -> T {
        if let _ = T.self as? UIPanGestureRecognizer.Type {
            let recognizer = UIPanGestureRecognizer(target: self, action: #selector(UIGestureRecognizer.trigger))
            recognizer.closureWrapper = ClosureWrapper(closure: closure)
            return recognizer as! T
        } else if let _ = T.self as? UIScreenEdgePanGestureRecognizer.Type {
            let recognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(UIGestureRecognizer.trigger))
            recognizer.closureWrapper = ClosureWrapper(closure: closure)
            return recognizer as! T
        } else {
            fatalError("Impossible to create recognizer for unrecognized gesture type")
        }
    }
}

public extension UILongPressGestureRecognizer {
    
    /**
     Creates and returns a gesture recognizer that performs a specific closure instead of a selector
     
     - parameter closure: The closure to execute
     
     - returns: The newly created UIGestureRecognizer subclass
     */
    public static func recognizerPerforms(closure: @escaping () -> ()) -> UILongPressGestureRecognizer {
        let recognizer = UILongPressGestureRecognizer(target: self, action: #selector(UIGestureRecognizer.trigger))
        recognizer.closureWrapper = ClosureWrapper(closure: closure)
        return recognizer
    }
}

