//
//  UIViewControllerExtensions.swift
//  SwiftHelpSet
//
//  Created by Luca D'Alberti on 8/23/16.
//  Copyright © 2016 dalu93. All rights reserved.
//

import Foundation
import UIKit

public extension UIViewController {
    
    /**
     Shows on the `UIViewController` instance a newly created `UIAlertController` instance.
     
     The title will be "Error", the cancel button title will be "Ok" (can be overwritten)
     and the message will be the `localizedDescription` of the `NSError` instance
     
     - Note: Provide an `NSError` instance with a valid `localizedDescription`.
     
     - returns: Returns the `UIAlertController` instance
     */
    public func showAlertFor(error: NSError, cancelTitle: String = "Ok", animated: Bool = true, completion: @escaping (() -> ()) = {}) -> UIAlertController {
        
        let alertController = UIAlertController(
            title: "Error",
            message: error.localizedDescription,
            preferredStyle: .alert
        )
        
        let cancelAction = UIAlertAction(
            title: cancelTitle,
            style: .cancel,
            handler: nil
        )
        
        alertController.addAction(cancelAction)
        self.present(alertController, animated: animated, completion: completion)
        return alertController
    }
}
