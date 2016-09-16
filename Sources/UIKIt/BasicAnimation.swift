//
//  BasicAnimation.swift
//  SwiftHelpSet
//
//  Created by Luca D'Alberti on 7/15/16.
//  Copyright © 2016 dalu93. All rights reserved.
//

import Foundation
import UIKit

/**
 It describes all the available axes
 
 - x: The X axis
 - y: The Y axis
 - z: The Z axis
 */
public enum Axis: String {
    case x
    case y
    case z
}

/// This wrapper allows you to handle easily the CABasicAnimation using closures
public class BasicAnimation: NSObject {
    
    fileprivate var _onStop: ((_ finished: Bool) -> ())?
    /// Called when the animation finishes
    public func onStop(closure: @escaping ((_ finished: Bool) -> ())) -> Self {
        _onStop = closure
        return self
    }
    
    fileprivate var _onStart: VoidClosure?
    /// Called when the animation starts
    public func onStart(closure: @escaping VoidClosure) -> Self {
        _onStart = closure
        return self
    }
    
    fileprivate let animation: CABasicAnimation
    fileprivate weak var layer: CALayer?
    
    /**
     Creates a new instance of `BasicAnimation` starting from a `CABasicAnimation` instance.
     
     It's recomended to use the static initializers
     
     - parameter animation: CABasicAnimation instance
     
     - returns: New `BasicAnimation` instance
     */
    public init(animation: CABasicAnimation) {
        
        self.animation = animation
        
        super.init()
        
        self.animation.delegate = self
    }
    
    /**
     Add and starts the animation on the layer
     
     - parameter layer: Layer on which add the animation
     
     - returns: `BasicAnimation` instance
     */
    public func add(to layer: CALayer) -> Self {
        self.layer = layer
        layer.add(animation, forKey: animation.keyPath)
        return self
    }
    
    /**
     Stops and removes the animation from the layer
     
     - returns: `BasicAnimation` instance
     */
    public func remove() -> Self {
        guard
            let layer = layer,
            let keyPath = animation.keyPath else { return self }
        
        layer.removeAnimation(forKey: keyPath)
        
        return self
    }
    
    deinit {
        _ = remove()
    }
}

public func ==(lhs: BasicAnimation, rhs: BasicAnimation) -> Bool {
    return lhs.animation == rhs.animation && lhs.layer == rhs.layer
}

// MARK: - Static initializers
public extension BasicAnimation {
    
    /**
     Creates a new instance of `BasicAnimation` that allows you to create a 
     simple rotation animation
     
     - parameter axis:        The axis on which rotate
     - parameter repeatCount: The repeat count
     - parameter duration:    The animation duration
     
     - returns: `BasicAnimation` instance
     */
    static public func rotationAnimation(on axis: Axis = .z, repeatCount: Float = HUGE, duration: CFTimeInterval = 1.0) -> BasicAnimation {
        
        let animation = CABasicAnimation(keyPath: "transform.rotation.\(axis.rawValue)")
        
        animation.toValue = NSNumber(value: M_PI * 2)
        animation.duration = duration
        animation.repeatCount = repeatCount
        
        return BasicAnimation(animation: animation)
    }
}

// MARK: - CAAnimationDelegate
extension BasicAnimation: CAAnimationDelegate {
    public func animationDidStart(_ anim: CAAnimation) {
        _onStart?()
    }
    
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        _onStop?(flag)
    }
}
