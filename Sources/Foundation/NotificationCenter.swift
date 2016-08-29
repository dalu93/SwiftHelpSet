//
//  NotificationCenter.swift
//  SwiftHelpSet
//
//  Created by Luca D'Alberti on 7/14/16.
//  Copyright © 2016 dalu93. All rights reserved.
//

import Foundation

/// Shared `NotificationCenter` instance
public let NotificationCenter = NotificationCenterManager.sharedManager

/// Functional and easy wrap around `NSNotificationCenter` `Foundation` API
public class NotificationCenterManager {
    private static let sharedManager = NotificationCenterManager()
    
    /// The common handler called when the notification is triggered
    public typealias GeneralNotificationHandler = (notification: NSNotification) -> ()
    
    /**
     Adds a new observer for the specific notification name
     
     The queue is the `NSOperationQueue.mainQueue()` by default.
     It returns a new `NSObjectProtocol` object that represents the observer
     
     - parameter name:    Notification's name
     - parameter object:  The object. Default is `nil`
     - parameter queue:   The specific queue. Default is `NSOperationQueue.mainQueue()`
     - parameter handler: The handler called when the notification is triggered
     
     - returns: `NSObjectProtocol` observer
     */
    public func addObserverFor(name name: String, object: AnyObject? = nil, queue: NSOperationQueue? = NSOperationQueue.mainQueue(), handler: GeneralNotificationHandler) -> NSObjectProtocol {
        
        return NSNotificationCenter.defaultCenter().addObserverForName(
            name,
            object: object,
            queue: queue,
            usingBlock: handler
        )
    }
    
    /**
     Removes an `NSObjectProtocol` observer as observer
     
     - parameter observer: The observer to remove
     
     - returns: The same `NotificationCenter` instance
     */
    public func remove(observer observer: NSObjectProtocol) -> Self {
        NSNotificationCenter.defaultCenter().removeObserver(observer)
        return self
    }
    
    /**
     Removes an array of `NSObjectProtocol` observer as observer
     
     - parameter observer: The observers to remove
     
     - returns: The same `NotificationCenter` instance
     */
    public func remove(observers observers: [NSObjectProtocol]) -> Self {
        observers.forEach { NotificationCenter.remove(observer: $0) }
        return self
    }
    
    /**
     Posts a `NSNotification`
     
     - parameter notification: The notification to post
     
     - returns: The same `NotificationCenter` instance
     */
    public func post(notification notification: NSNotification) -> Self {
        NSNotificationCenter.defaultCenter().postNotification(notification)
        return self
    }
    
    /**
     Post a `NSNotification` by providing some basic information
     
     - parameter name:     Notification's name
     - parameter object:   The object
     - parameter userInfo: The dictionary to attach
     
     - returns: The same `NotificationCenter` instance
     */
    public func postNotification(with name: String, object: AnyObject? = nil, userInfo: [NSObject:AnyObject]? = nil) -> Self {
        post(
            notification: NSNotification(
                name: name,
                object: object,
                userInfo: userInfo
            )
        )
        
        return self
    }
}