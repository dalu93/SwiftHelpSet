//
//  UIViewExtensions.swift
//  SwiftHelpSet
//
//  Created by Luca D'Alberti on 7/29/16.
//  Copyright © 2016 dalu93. All rights reserved.
//

import UIKit

// MARK: - UIView support
public extension UIView {
    
    /**
     Pins the view to the superview edges (Top, Bottom, Trailing and Leading).
     
     The superview property of the view cannot be nil
     
     - parameter edge: The edge to constraint
     */
    public func pinToSuperView(edge: ViewEdgeType) {
        
        let superview = _setup()
        
        switch edge {
            
        case .all:
            pinToSuperView(edge: .top)
            pinToSuperView(edge: .bottom)
            pinToSuperView(edge: .leading)
            pinToSuperView(edge: .trailing)
            
        case .top:
            superview.addConstraint(
                .PinTop(
                    view: self,
                    superview: superview
                )
            )
            
        case .bottom:
            superview.addConstraint(
                .PinBottom(
                    view: self,
                    superview: superview
                )
            )
            
        case .leading:
            superview.addConstraint(
                .PinLeading(
                    view: self,
                    superview: superview
                )
            )
            
        case .trailing:
            superview.addConstraint(
                .PinTrailing(
                    view: self,
                    superview: superview
                )
            )
        }
    }
    
    public func centerInSuperview() {
        let superview = _setup()
        
        superview.addConstraints(NSLayoutConstraint.Center(view: self, on: superview))
    }
    
    /**
     Pins a dimension or both
     
     - parameter dimension: Dimension description
     */
    public func pin(dimension: ViewDimensionType) {
        
        let superview = _setup()
        
        switch dimension {
        case .all(let width, let height):
            pin(dimension: .height(height))
            pin(dimension: .width(width))
            
        case .height(let height):
            superview.addConstraint(
                NSLayoutConstraint.PinHeight(
                    view: self,
                    value: height
                )
            )
            
        case .width(let width):
            superview.addConstraint(
                NSLayoutConstraint.PinWidth(
                    view: self,
                    value: width
                )
            )
        }
    }
    
    /**
     Makes a `UIView` instance rounded with a specific `radius`
     
     - parameter radius: The radius
     */
    public func roundWith(radius: CGFloat) {
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
    }
    
    /**
     Animates the `UIView` changes in the `animations` closure
     
     - parameter animations:    The closure with view changes
     - parameter duration:      The duration
     - parameter completion:    The completion closure
     */
    static func animate(with animations: @escaping () -> (), duration: TimeInterval, completion: @escaping ((Bool) -> ()) = { _ in }) {
        UIView.animate(
            withDuration: duration,
            animations: animations,
            completion: completion
        )
    }
}

// MARK: - UIActivityIndicator shortcut
public extension UIView {
    
    /**
     Creates and return a centered UIActivityIndicatorView with a specific style.
     
     The UIActivityIndicatorView is initialized with the property 
     `hidesWhenStopped` equal to `true`. It is, then, added in the view hierarchy.
     
     - Note:    Please, do not add again the UIActivityIndicatorView to your view
                hiearchy. It is already added.
     
     - parameter style: The UIActivityIndicatorViewStyle
     
     - returns: A centered UIActivityIndicatorView instance
     */
    public func centeredActivityIndicatorView(with style: UIActivityIndicatorViewStyle) -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: style)
        
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(indicator)
        
        addConstraints(NSLayoutConstraint.Center(view: indicator, on: self))
        
        return indicator
    }
}

// MARK: - Helpers
private extension UIView {
    
    func _setup() -> UIView {
        
        guard let superview = superview else { fatalError("The view has no superview in this moment: \(#line)") }
        translatesAutoresizingMaskIntoConstraints = false
        
        return superview
    }
}
