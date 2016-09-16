//
//  NotificationCenter.swift
//  SwiftHelpSet
//
//  Created by Luca D'Alberti on 7/14/16.
//  Copyright © 2016 dalu93. All rights reserved.
//

import Foundation

/// Shared `NotificationCenter` instance
public let NotificationManager = NotificationCenterManager.default

/// Functional and easy wrap around `NSNotificationCenter` `Foundation` API
public class NotificationCenterManager {
    fileprivate static let `default` = NotificationCenterManager()
    
    /// The common handler called when the notification is triggered
    public typealias GeneralNotificationHandler = (_ notification: Notification) -> ()
    
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
    public func addObserverFor(name: NSNotification.Name, object: AnyObject? = nil, queue: OperationQueue? = OperationQueue.main, handler: @escaping GeneralNotificationHandler) -> NSObjectProtocol {
        
        return NotificationCenter.default.addObserver(
            forName: name,
            object: object,
            queue: queue,
            using: handler
        )
    }
    
    public func addObserverFor(names: [NSNotification.Name], object: AnyObject? = nil, queue: OperationQueue? = OperationQueue.main, handler: @escaping GeneralNotificationHandler) -> [NSObjectProtocol] {
        
        return names.map { NotificationManager.addObserverFor(name: $0, handler: handler) }
    }
    
    /**
     Removes an `NSObjectProtocol` observer as observer
     
     - parameter observer: The observer to remove
     
     - returns: The same `NotificationCenter` instance
     */
    public func remove(observer: NSObjectProtocol) -> Self {
        NotificationCenter.default.removeObserver(observer)
        return self
    }
    
    /**
     Removes an array of `NSObjectProtocol` observer as observer
     
     - parameter observer: The observers to remove
     
     - returns: The same `NotificationCenter` instance
     */
    public func remove(observers: [NSObjectProtocol]) -> Self {
        observers.forEach { _ = NotificationManager.remove(observer: $0) }
        return self
    }
    
    /**
     Posts a `NSNotification`
     
     - parameter notification: The notification to post
     
     - returns: The same `NotificationCenter` instance
     */
    public func post(notification: Notification) -> Self {
        NotificationCenter.default.post(notification)
        return self
    }
    
    /**
     Post a `NSNotification` by providing some basic information
     
     - parameter name:     Notification's name
     - parameter object:   The object
     - parameter userInfo: The dictionary to attach
     
     - returns: The same `NotificationCenter` instance
     */
    public func postNotification(with name: NSNotification.Name, object: AnyObject? = nil, userInfo: [NSObject:AnyObject]? = nil) -> Self {
        _ = post(
            notification: Notification(
                name: name,
                object: object,
                userInfo: userInfo
            )
        )
        
        return self
    }
}
