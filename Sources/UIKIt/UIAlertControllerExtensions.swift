//
//  UIAlertControllerExtensions.swift
//  SwiftHelpSet
//
//  Created by Luca D'Alberti on 9/7/16.
//  Copyright © 2016 dalu93. All rights reserved.
//

import UIKit

// MARK: - Utility methods
public extension UIAlertController {
    
    /**
     Creates and returns a `UIAlertController` instance with `.Alert` style
     
     - parameter title:   The title
     - parameter message: The message
     - parameter actions: A list of actions to add
     
     - returns: Returns a `UIAlertController` instance with `.Alert` style
     */
    static func alertWith(title: String? = "", message: String? = "", actions: [UIAlertAction] = []) -> UIAlertController {
        let controller = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        controller.add(actions)
        
        return controller
    }
    
    func add(_ actions: [UIAlertAction]) {
        actions.forEach { self.addAction($0) }
    }
    
    func test() {
        let alertController = UIAlertController.alertWith(message: "An error occured")
        
        let cancelAction = UIAlertAction.Cancel()
        let doneAction = UIAlertAction.Done()
        
        alertController.add([
            doneAction,
            cancelAction
        ])
        
        // present the controller
    }
}

// MARK: - Utility methods
public extension UIAlertAction {
    
    /**
     Quickly creates and returns a new `UIAlertAction` with `.Cancel` style.
     
     Title default parameter is "Cancel" and you can change it by calling the complete
     method
     
     - parameter title:   The title. The default value is "Cancel"
     - parameter handler: The handler
     
     - returns: Returns a new `UIAlertAction` with `.Cancel` style.
     */
    static func Cancel(title: String? = "Cancel", handler: ((UIAlertAction) -> ())? = nil) -> UIAlertAction {
        return UIAlertAction(title: title, style: .cancel, handler: handler)
    }

    
    /**
     Quickly creates and returns a new `UIAlertAction` with `.Default` style.
     
     Title default parameter is "Done" and you can change it by calling the complete
     method
     
     - parameter title:   The title. The default value is "Done"
     - parameter handler: The handler
     
     - returns: Returns a new `UIAlertAction` with `.Default` style.
     */
    static func Done(title: String? = "Done", handler: ((UIAlertAction) -> ())? = nil) -> UIAlertAction {
        return UIAlertAction(title: title, style: .default, handler: handler)
    }
}
