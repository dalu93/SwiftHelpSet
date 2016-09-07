//
//  NSLayoutConstraintExtensions.swift
//  SwiftHelpSet
//
//  Created by Luca D'Alberti on 7/14/16.
//  Copyright © 2016 dalu93. All rights reserved.
//

import Foundation
import UIKit

/**
 Enum that rapresents the view edges
 
 - all:      All the edges
 - top:      Top edge
 - bottom:   Bottom edge
 - leading:  Leading edge
 - trailing: Trailing edge
 */
public enum ViewEdgeType: Int {
    
    case all
    case top
    case bottom
    case leading
    case trailing
}

/**
 Enum that describes the view dimensions
 
 - all:    Both width and heoght
 - height: The height
 - width:  The width
 */
public enum ViewDimensionType {
    
    case all(width: CGFloat, height: CGFloat)
    case height(CGFloat)
    case width(CGFloat)
}

// MARK: - NSLayoutConstraint support
extension NSLayoutConstraint {
    
    /**
     Pins the top edge of the `view` to the top edge of the `superview`.
     
     - parameter view:      The view
     - parameter superview: The superview
     - parameter distance:  A specific distance from the edges
     
     - returns: The `NSLayoutConstraint` instance
     */
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
    
    
    /**
     Pins the bottom edge of the `view` to the bottom edge of the `superview`.
     
     - parameter view:      The view
     - parameter superview: The superview
     - parameter distance:  A specific distance from the edges
     
     - returns: The `NSLayoutConstraint` instance
     */
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
    
    /**
     Pins the trailing edge of the `view` to the trailing edge of the `superview`.
     
     - parameter view:      The view
     - parameter superview: The superview
     - parameter distance:  A specific distance from the edges
     
     - returns: The `NSLayoutConstraint` instance
     */
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
    
    
    /**
     Pins the leading edge of the `view` to the leading edge of the `superview`.
     
     - parameter view:      The view
     - parameter superview: The superview
     - parameter distance:  A specific distance from the edges
     
     - returns: The `NSLayoutConstraint` instance
     */
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
    
    
    /**
     Pins the height to a specific value
     
     - parameter view:  The view
     - parameter value: The height value
     
     - returns: The `NSLayoutConstraint` instance
     */
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
    
    /**
     Pins the width to a specific value
     
     - parameter view:  The view
     - parameter value: The width value
     
     - returns: The `NSLayoutConstraint` instance
     */
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
    
    /**
     Centers the `view` in the `superview` with a specific offset
     
     - parameter view:      The view
     - parameter superview: The superview
     - parameter offset:    The offset. Default is (0, 0)
     
     - returns: The `NSLayoutConstraint` array
     */
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
    
    
    /**
     It animates a change of `NSLayoutConstraint` constant.
     
     - parameter newConstant: The new constant
     - parameter duration:    The animation duration
     - parameter completion:  The completion closure
     */
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