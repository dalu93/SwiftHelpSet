//
//  NotificationContainer.swift
//  SwiftHelpSet
//
//  Created by Luca D'Alberti on 9/23/16.
//  Copyright © 2016 dalu93. All rights reserved.
//

import Foundation

fileprivate protocol ObserverDescriptorType {
    var name: NSNotification.Name { get }
    var observer: NSObjectProtocol { get }
}

// MARK: - ObserverDescriptor declaration
fileprivate struct ObserverDescriptor: ObserverDescriptorType {
    let name: NSNotification.Name
    let observer: NSObjectProtocol
}

public protocol NotificationContainerType {
    func removeObserver(with name: NSNotification.Name)
    func addObserverFor(name: NSNotification.Name, object: AnyObject?, queue: OperationQueue?, handler: @escaping GeneralNotificationHandler)
    func addObserverFor(names: [NSNotification.Name], object: AnyObject?, queue: OperationQueue?, handler: @escaping GeneralNotificationHandler)
}

// MARK: - ObserverDescriptor declaration
/// The `NotificationContainer` class provides a set of utilities to manage the
/// `Notification`s without caring of storing the observers and remove them.
public class NotificationContainer: NotificationContainerType {
    
    fileprivate var activeObserversDescriptors: [ObserverDescriptorType] = []
    
    
    /// Asks to remove an observer.
    ///
    /// It removes any observer for the same `NSNotification.Name` value.
    /// - parameter name: The notification's name
    public func removeObserver(with name: NSNotification.Name) {
        _removeObserver(name)
    }
    
    
    /// Adds a new observer for the notification
    ///
    /// - parameter name:    The notification's name
    /// - parameter object:  The object
    /// - parameter queue:   The queue
    /// - parameter handler: The handler
    public func addObserverFor(name: NSNotification.Name, object: AnyObject? = nil, queue: OperationQueue? = OperationQueue.main, handler: @escaping GeneralNotificationHandler) {
        let observer = NotificationManager.addObserverFor(
            name: name,
            object: object,
            queue: queue,
            handler: handler
        )
        
        let descriptor = ObserverDescriptor(
            name: name,
            observer: observer
        )
        
        activeObserversDescriptors.append(descriptor)
    }
    
    
    /// Adds new observers for the notification
    ///
    /// - parameter names:   The notification's names
    /// - parameter object:  The object
    /// - parameter queue:   The queue
    /// - parameter handler: The handler
    public func addObserverFor(names: [NSNotification.Name], object: AnyObject? = nil, queue: OperationQueue? = OperationQueue.main, handler: @escaping GeneralNotificationHandler) {
        names.forEach { self.addObserverFor(name: $0, object: object, queue: queue, handler: handler) }
    }
    
    deinit {
        activeObserversDescriptors.forEach {
            _removeObserver($0.name)
        }
        
        if activeObserversDescriptors.count > 0 { fatalError("There are still \(activeObserversDescriptors.count) active descriptors. They should be 0") }
    }
}

// MARK: - Logic helpers
fileprivate extension NotificationContainer {
    
    func _removeObserver(_ name: NSNotification.Name) {
        for descriptor in activeObserversDescriptors {
            if descriptor.name == name {
                _ = NotificationManager.remove(observer: descriptor.observer)
            }
        }
        
        activeObserversDescriptors = activeObserversDescriptors.filter { $0.name != name }
    }
}
