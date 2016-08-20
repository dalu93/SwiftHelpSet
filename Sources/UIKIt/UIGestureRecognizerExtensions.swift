//
//  UIGestureRecognizerExtensions.swift
//  SwiftHelpSet
//
//  Created by Luca D'Alberti on 8/19/16.
//  Copyright © 2016 dalu93. All rights reserved.
//

import UIKit

private var _UIGestureRecognizerClosure: StaticString = "UIGestureRecognizerClosure"

extension UIGestureRecognizer {
    
    private var closureWrapper: ClosureWrapper? {
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

extension UITapGestureRecognizer {
    public static func recognizerPerforms(closure: () -> ()) -> UITapGestureRecognizer {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(UIGestureRecognizer.trigger))
        recognizer.closureWrapper = ClosureWrapper(closure: closure)
        return recognizer
    }
}

extension UIPinchGestureRecognizer {
    public static func recognizerPerforms(closure: () -> ()) -> UIPinchGestureRecognizer {
        let recognizer = UIPinchGestureRecognizer(target: self, action: #selector(UIGestureRecognizer.trigger))
        recognizer.closureWrapper = ClosureWrapper(closure: closure)
        return recognizer
    }
}

extension UIRotationGestureRecognizer {
    public static func recognizerPerforms(closure: () -> ()) -> UIRotationGestureRecognizer {
        let recognizer = UIRotationGestureRecognizer(target: self, action: #selector(UIGestureRecognizer.trigger))
        recognizer.closureWrapper = ClosureWrapper(closure: closure)
        return recognizer
    }
}

extension UISwipeGestureRecognizer {
    public static func recognizerPerforms(closure: () -> ()) -> UISwipeGestureRecognizer {
        let recognizer = UISwipeGestureRecognizer(target: self, action: #selector(UIGestureRecognizer.trigger))
        recognizer.closureWrapper = ClosureWrapper(closure: closure)
        return recognizer
    }
}

extension UIPanGestureRecognizer {
    public static func recognizerPerforms<T>(closure: () -> ()) -> T {
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

extension UILongPressGestureRecognizer {
    public static func recognizerPerforms(closure: () -> ()) -> UILongPressGestureRecognizer {
        let recognizer = UILongPressGestureRecognizer(target: self, action: #selector(UIGestureRecognizer.trigger))
        recognizer.closureWrapper = ClosureWrapper(closure: closure)
        return recognizer
    }
}

