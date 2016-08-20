//
//  UITableViewExtensions.swift
//  SwiftHelpSet
//
//  Created by Luca D'Alberti on 7/19/16.
//  Copyright © 2016 dalu93. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    
    /**
     Asks a `ReusableView` instance dequeued from the `UITableView`.
     
     Example: \
     \
     `let cell: YourCellClass = tableView.dequeueReusableCell()` \
     where `YourCellClass` is a `UITableViewCell` conforming to `ReusableView` protocol
     
     - Note:    It raises an exception when a `UITableViewCell` instance cannot be
                dequeued.
     
     - SeeAlso: `ReusableView`
     
     - returns: Dequeue `UITableViewCell` instance
     */
    public func dequeueReusableCell<T where T: UITableViewCell, T: ReusableView>() -> T {
        guard let cell = self.dequeueReusableCellWithIdentifier(T.identifier) as? T else {
            fatalError("A cell with \(T.identifier) identifier cannot be dequeued")
        }
        
        return cell
    }
    
    /**
     Asks a `UITableViewCell` instance dequeued from the `UITableView`.
     
     Example: \
     \
     `let cell: YourCellClass = tableView.dequeueReusableCell()` \
     where `YourCellClass` is a `UITableViewCell`
     
     - Note:    It raises an exception when a `UITableViewCell` instance cannot be
     dequeued.
     
     - Note:    The cell identifier **must** be equal to the class name
     
     - returns: Dequeue `UITableViewCell` instance
     */
    public func dequeueReusableCell<T: UITableViewCell>() -> T {
        guard let cell = self.dequeueReusableCellWithIdentifier(String(T)) as? T else {
            fatalError("A cell with \(String(T)) identifier cannot be dequeued")
        }
        
        return cell
    }
    
    
    /**
     Registers the cell for the `UITableView` instance.
     
     The cell has to conform to `ReusableView` protocol.
     
     - SeeAlso: `ReusableView`
     
     - parameter type: The cell type
     */
    public func registerCell<T where T: UITableViewCell, T: ReusableView>(type: T.Type) {
        registerNib(
            T.nib,
            forCellReuseIdentifier: T.identifier
        )
    }
    
    /**
     Registers the cell for the `UITableView` instance.
     
     - parameter type: The cell type
     */
    public func registerCell<T: UITableViewCell>(type: T.Type) {
        registerClass(T.self, forCellReuseIdentifier: String(T))
    }
    
    /**
     Tells the `UITableView` instance to set the row dimension as automatic
     
     - parameter estimatedRowHeight: The estimated row height. Default is `100`
     */
    public func setupAutomaticDimension(to estimatedRowHeight: CGFloat = 100) {
        self.estimatedRowHeight = estimatedRowHeight
        self.rowHeight = UITableViewAutomaticDimension
    }
    
    
    /**
     Adds a default `UIRefreshControl` instance to the `UITableView`
     
     - parameter block: Code to execute when the refresh control is triggered
     
     - returns: The newly created `UIRefreshControl` instance
     */
    public func addRefreshControl(performing block: () -> ()) -> UIRefreshControl {
        let refreshControl = UIRefreshControl()
        
        refreshControl.bind(.ValueChanged) { block() }
        
        self.addSubview(refreshControl)
        
        return refreshControl
    }
}