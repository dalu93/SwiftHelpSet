//
//  NSLayoutConstraintExtensions.swift
//  SwiftHelpSet
//
//  Created by Luca D'Alberti on 7/14/16.
//  Copyright © 2016 dalu93. All rights reserved.
//

import Foundation
import UIKit

public enum ViewEdgeType: Int {
    
    case all
    case top
    case bottom
    case leading
    case trailing
}

public enum ViewDimensionType {
    
    case all(width: CGFloat, height: CGFloat)
    case height(CGFloat)
    case width(CGFloat)
}

// MARK: - NSLayoutConstraint support
extension NSLayoutConstraint {
    
    static public func PinTop(view: UIView, superview: UIView, distance: CGFloat = 0) -> NSLayoutConstraint {
        
        return NSLayoutConstraint(
            item: view,
            attribute: .top,
            relatedBy: .equal,
            toItem: superview,
            attribute: .top,
            multiplier: 1,
            constant: distance
        )
    }
    
    static public func PinBottom(view: UIView, superview: UIView, distance: CGFloat = 0) -> NSLayoutConstraint {
        
        return NSLayoutConstraint(
            item: view,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: superview,
            attribute: .bottom,
            multiplier: 1,
            constant: distance
        )
    }
    
    static public func PinTrailing(view: UIView, superview: UIView, distance: CGFloat = 0) -> NSLayoutConstraint {
        
        return NSLayoutConstraint(
            item: view,
            attribute: .trailing,
            relatedBy: .equal,
            toItem: superview,
            attribute: .trailing,
            multiplier: 1,
            constant: distance
        )
    }
    
    static public func PinLeading(view: UIView, superview: UIView, distance: CGFloat = 0) -> NSLayoutConstraint {
        
        return NSLayoutConstraint(
            item: view,
            attribute: .leading,
            relatedBy: .equal,
            toItem: superview,
            attribute: .leading,
            multiplier: 1,
            constant: distance
        )
    }
    
    static public func PinHeight(view: UIView, value: CGFloat) -> NSLayoutConstraint {
        
        return NSLayoutConstraint(
            item: view,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: value
        )
    }
    
    static public func PinWidth(view: UIView, value: CGFloat) -> NSLayoutConstraint {
        
        return NSLayoutConstraint(
            item: view,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: value
        )
    }
    
    static public func Center(view: UIView, on superview: UIView, with offset: (x: CGFloat, y: CGFloat) = (0,0)) -> [NSLayoutConstraint] {
        
        return [
            NSLayoutConstraint(
                item: view,
                attribute: .centerX,
                relatedBy: .equal,
                toItem: superview,
                attribute: .centerX,
                multiplier: 1,
                constant: offset.x
            ),
            NSLayoutConstraint(
                item: view,
                attribute: .centerY,
                relatedBy: .equal,
                toItem: superview,
                attribute: .centerY,
                multiplier: 1,
                constant: offset.y
            )
        ]
    }
    
    public func animate(newConstant: CGFloat, duration: TimeInterval = 0.3, completion: (() -> ())?) {
        
        guard let superview = secondItem as? UIView else { return }
        
        constant = newConstant
        
        UIView.animate(
            withDuration: duration,
            animations: { 
                superview.layoutIfNeeded()
            }) { _ in
                completion?()
        }
    }
}
