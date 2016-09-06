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
    func bindKeyboardSize(closure: (_ size: CGSize) -> ()) -> NSObjectProtocol
}

extension KeyboardObserver where Self: UIViewController {

    public func bindKeyboardSize(closure: @escaping (_ size: CGSize) -> ()) -> [NSObjectProtocol] {
        
        return NotificationManager.addObserverFor(names: [.UIKeyboardWillChangeFrame, .UIKeyboardWillHide]) { n in
            
            guard
                let userInfo = n.userInfo,
                let keyboardSize = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size else { return }
            
            closure(keyboardSize)
        }
    }
}
