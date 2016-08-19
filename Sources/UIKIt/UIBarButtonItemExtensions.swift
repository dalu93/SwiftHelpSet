//
//  UIBarButtonItemExtensions.swift
//  SwiftHelpSet
//
//  Created by Luca D'Alberti on 8/16/16.
//  Copyright © 2016 dalu93. All rights reserved.
//

import UIKit

private var _UIBarButtonItemClosure: StaticString = "UIBarButtonItemClosure"

extension UIBarButtonItem {
    
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
    
    public static func itemWith(title title: String?, style: UIBarButtonItemStyle = .Plain, closure: (AnyObject) -> ()) -> UIBarButtonItem {
        let item = UIBarButtonItem(
            title: title,
            style: style,
            target: self,
            action: #selector(UIBarButtonItem.selector(_:))
        )
        
        item.closureWrapper = ClosureWrapper(closure: closure)
        
        return item
    }
    
    public static func itemWith(image image: UIImage?, landscapeImage: UIImage? = nil, style: UIBarButtonItemStyle = .Plain, closure: (AnyObject) -> ()) -> UIBarButtonItem {
        let item = UIBarButtonItem(
            image: image,
            landscapeImagePhone: landscapeImage,
            style: style,
            target: self,
            action: #selector(UIBarButtonItem.selector(_:))
        )
        
        item.closureWrapper = ClosureWrapper(closure: closure)
        
        return item
    }
    
    public static func itemWith(barButtonSystemItem barButtonSystemItem: UIBarButtonSystemItem, closure: (AnyObject) -> ()) -> UIBarButtonItem {
        let item = UIBarButtonItem(
            barButtonSystemItem: barButtonSystemItem,
            target: self,
            action: #selector(UIBarButtonItem.selector(_:))
        )
        
        item.closureWrapper = ClosureWrapper(closure: closure)
        
        return item
    }
    
    @objc private func selector(sender: UIBarButtonItem) {
        closureWrapper?.closure(sender)
    }
}
