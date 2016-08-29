//
//  UIViewControllerExtensions.swift
//  SwiftHelpSet
//
//  Created by Luca D'Alberti on 8/23/16.
//  Copyright © 2016 dalu93. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    public func showAlertFor(error: NSError, cancelTitle: String = "Ok", animated: Bool = true, completion: () -> () = {}) -> UIAlertController {
        let alertController = UIAlertController(
            title: "Error",
            message: error.localizedDescription,
            preferredStyle: .Alert
        )
        
        let cancelAction = UIAlertAction(
            title: cancelTitle,
            style: .Cancel,
            handler: nil
        )
        
        alertController.addAction(cancelAction)
        self.presentViewController(alertController, animated: animated, completion: completion)
        return alertController
    }
}