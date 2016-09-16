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
public extension NSLayoutConstraint {
    
    /**
     Pins the top edge of the `view` to the top edge of the `superview`.
     
     - parameter view:      The view
     - parameter superview: The superview
     - parameter distance:  A specific distance from the edges
     
     - returns: The `NSLayoutConstraint` instance
     */
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
    
    /**
     Pins the bottom edge of the `view` to the bottom edge of the `superview`.
     
     - parameter view:      The view
     - parameter superview: The superview
     - parameter distance:  A specific distance from the edges
     
     - returns: The `NSLayoutConstraint` instance
     */
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
    
    /**
     Pins the trailing edge of the `view` to the trailing edge of the `superview`.
     
     - parameter view:      The view
     - parameter superview: The superview
     - parameter distance:  A specific distance from the edges
     
     - returns: The `NSLayoutConstraint` instance
     */
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
    
    /**
     Pins the leading edge of the `view` to the leading edge of the `superview`.
     
     - parameter view:      The view
     - parameter superview: The superview
     - parameter distance:  A specific distance from the edges
     
     - returns: The `NSLayoutConstraint` instance
     */
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
    
    /**
     Pins the height to a specific value
     
     - parameter view:  The view
     - parameter value: The height value
     
     - returns: The `NSLayoutConstraint` instance
     */
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
    
    /**
     Pins the width to a specific value
     
     - parameter view:  The view
     - parameter value: The width value
     
     - returns: The `NSLayoutConstraint` instance
     */
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
    
    /**
     Centers the `view` in the `superview` with a specific offset
     
     - parameter view:      The view
     - parameter superview: The superview
     - parameter offset:    The offset. Default is (0, 0)
     
     - returns: The `NSLayoutConstraint` array
     */
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
    
    /**
     It animates a change of `NSLayoutConstraint` constant.
     
     - parameter newConstant: The new constant
     - parameter duration:    The animation duration
     - parameter completion:  The completion closure
     */
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
