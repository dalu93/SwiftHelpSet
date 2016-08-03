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
    
    static public func PinTop(view view: UIView, superview: UIView, distance: CGFloat = 0) -> NSLayoutConstraint {
        
        return NSLayoutConstraint(
            item: view,
            attribute: .Top,
            relatedBy: .Equal,
            toItem: superview,
            attribute: .Top,
            multiplier: 1,
            constant: distance
        )
    }
    
    static public func PinBottom(view view: UIView, superview: UIView, distance: CGFloat = 0) -> NSLayoutConstraint {
        
        return NSLayoutConstraint(
            item: view,
            attribute: .Bottom,
            relatedBy: .Equal,
            toItem: superview,
            attribute: .Bottom,
            multiplier: 1,
            constant: distance
        )
    }
    
    static public func PinTrailing(view view: UIView, superview: UIView, distance: CGFloat = 0) -> NSLayoutConstraint {
        
        return NSLayoutConstraint(
            item: view,
            attribute: .Trailing,
            relatedBy: .Equal,
            toItem: superview,
            attribute: .Trailing,
            multiplier: 1,
            constant: distance
        )
    }
    
    static public func PinLeading(view view: UIView, superview: UIView, distance: CGFloat = 0) -> NSLayoutConstraint {
        
        return NSLayoutConstraint(
            item: view,
            attribute: .Leading,
            relatedBy: .Equal,
            toItem: superview,
            attribute: .Leading,
            multiplier: 1,
            constant: distance
        )
    }
    
    static public func PinHeight(view view: UIView, value: CGFloat) -> NSLayoutConstraint {
        
        return NSLayoutConstraint(
            item: view,
            attribute: .Height,
            relatedBy: .Equal,
            toItem: nil,
            attribute: .NotAnAttribute,
            multiplier: 1,
            constant: value
        )
    }
    
    static public func PinWidth(view view: UIView, value: CGFloat) -> NSLayoutConstraint {
        
        return NSLayoutConstraint(
            item: view,
            attribute: .Width,
            relatedBy: .Equal,
            toItem: nil,
            attribute: .NotAnAttribute,
            multiplier: 1,
            constant: value
        )
    }
    
    static public func Center(view view: UIView, on superview: UIView, with offset: (x: CGFloat, y: CGFloat) = (0,0)) -> [NSLayoutConstraint] {
        
        return [
            NSLayoutConstraint(
                item: view,
                attribute: .CenterX,
                relatedBy: .Equal,
                toItem: superview,
                attribute: .CenterX,
                multiplier: 1,
                constant: offset.x
            ),
            NSLayoutConstraint(
                item: view,
                attribute: .CenterY,
                relatedBy: .Equal,
                toItem: superview,
                attribute: .CenterY,
                multiplier: 1,
                constant: offset.y
            )
        ]
    }
    
    public func animate(newConstant: CGFloat, duration: NSTimeInterval = 0.3, completion: (() -> ())?) {
        
        guard let superview = secondItem as? UIView else { return }
        
        constant = newConstant
        
        UIView.animateWithDuration(
            duration,
            animations: { 
                superview.layoutIfNeeded()
            }) { _ in
                completion?()
        }
    }
}