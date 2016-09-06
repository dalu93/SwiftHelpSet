//
//  KeyboardObserver.swift
//  SwiftHelpSet
//
//  Created by Luca D'Alberti on 8/23/16.
//  Copyright © 2016 dalu93. All rights reserved.
//

import Foundation
import UIKit


public protocol KeyboardObserver {
    func bindKeyboardSize(closure: (size: CGSize) -> ()) -> NSObjectProtocol
}

extension KeyboardObserver where Self: UIViewController {
    public func bindKeyboardSize(closure: (size: CGSize) -> ()) -> [NSObjectProtocol] {
        
        return NotificationCenter.addObserverFor(names: [UIKeyboardWillChangeFrameNotification, UIKeyboardWillHideNotification]) { n in
            
            guard
                let userInfo = n.userInfo,
                let keyboardSize = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.CGRectValue().size else { return }
            
            closure(size: keyboardSize)
        }
    }
}