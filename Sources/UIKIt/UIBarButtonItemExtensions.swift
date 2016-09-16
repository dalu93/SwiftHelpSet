//
//  UIBarButtonItemExtensions.swift
//  SwiftHelpSet
//
//  Created by Luca D'Alberti on 8/16/16.
//  Copyright © 2016 dalu93. All rights reserved.
//

import UIKit

private var _UIBarButtonItemClosure: StaticString = "UIBarButtonItemClosure"

public extension UIBarButtonItem {
    
    private var closureWrapper: ClosureWrapper? {
        get {
            return objc_getAssociatedObject(self, &_UIBarButtonItemClosure) as? ClosureWrapper
        }
        
        set {
            objc_setAssociatedObject(
                self,
                &_UIBarButtonItemClosure,
                newValue,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
    
    /**
     Creates a new `UIBarButtonItem` with a specific closure instead of providing the selector
     
     - parameter title:   The title
     - parameter style:   The style
     - parameter closure: The closure to execute
     
     - returns: The newly created `UIBarButtonItem`
     */
    public static func itemWith(title: String?, style: UIBarButtonItemStyle = .plain, closure: @escaping () -> ()) -> UIBarButtonItem {
        let item = UIBarButtonItem(
            title: title,
            style: style,
            target: self,
            action: #selector(UIBarButtonItem.selector(sender:))
        )
        
        item.closureWrapper = ClosureWrapper(closure: closure)
        
        return item
    }
    
    /**
     Creates a new `UIBarButtonItem` with a specific closure instead of providing the selector
     
     - parameter image:          The image
     - parameter landscapeImage: The landscape image
     - parameter style:          The style
     - parameter closure:        The closure to execute
     
     - returns: The newly created `UIBarButtonItem`
     */
    public static func itemWith(image: UIImage?, landscapeImage: UIImage? = nil, style: UIBarButtonItemStyle = .plain, closure: @escaping () -> ()) -> UIBarButtonItem {
        let item = UIBarButtonItem(
            image: image,
            landscapeImagePhone: landscapeImage,
            style: style,
            target: self,
            action: #selector(UIBarButtonItem.selector(sender:))
        )
        
        item.closureWrapper = ClosureWrapper(closure: closure)
        
        return item
    }
    
    /**
     Creates a new `UIBarButtonItem` with a specific closure instead of providing the selector
     
     - parameter barButtonSystemItem: The system item
     - parameter closure:             The closure to execute
     
     - returns: The newly created `UIBarButtonItem`
     */
    public static func itemWith(barButtonSystemItem: UIBarButtonSystemItem, closure: @escaping () -> ()) -> UIBarButtonItem {
        let item = UIBarButtonItem(
            barButtonSystemItem: barButtonSystemItem,
            target: self,
            action: #selector(UIBarButtonItem.selector(sender:))
        )
        
        item.closureWrapper = ClosureWrapper(closure: closure)
        
        return item
    }
    
    @objc fileprivate func selector(sender: UIBarButtonItem) {
        closureWrapper?.closure()
    }
}
