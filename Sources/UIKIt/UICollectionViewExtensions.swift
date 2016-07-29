//
//  UICollectionViewExtensions.swift
//  SwiftHelpSet
//
//  Created by Luca D'Alberti on 7/29/16.
//  Copyright © 2016 dalu93. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    /**
     Asks a `ReusableView` instance dequeued from the `UICollectionView`.
     
     Example: \
     \
     `let cell: YourCellClass = collectionView.dequeueReusableCell()` \
     where `YourCellClass` is a `UICollectionViewCell` conforming to `ReusableView` protocol
     
     - Note:    It raises an exception when a `UICollectionViewCell` instance cannot be
     dequeued.
     
     - SeeAlso: `ReusableView`
     
     - returns: Dequeue `UICollectionViewCell` instance
     */
    public func dequeueReusableCell<T where T: UICollectionViewCell, T: ReusableView>(at indexPath: NSIndexPath) -> T {
        guard let cell = self.dequeueReusableCellWithReuseIdentifier(T.identifier, forIndexPath: indexPath) as? T else { fatalError("A cell with \(T.identifier) identifier cannot be dequeued") }
        
        return cell
    }
    
    /**
     Asks a `UICollectionViewCell` instance dequeued from the `UICollectionView`.
     
     Example: \
     \
     `let cell: YourCellClass = collectionView.dequeueReusableCell()` \
     where `YourCellClass` is a `UICollectionViewCell`
     
     - Note:    It raises an exception when a `UICollectionViewCell` instance cannot be
     dequeued.
     
     - returns: Dequeue `UICollectionViewCell` instance
     */
    public func dequeueReusableCell<T where T: UICollectionViewCell>(at indexPath: NSIndexPath) -> T {
        let identifier = String(T)
        
        guard let cell = self.dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: indexPath) as? T else { fatalError("A cell with \(identifier) identifier cannot be dequeued") }
        
        return cell
    }
    
    /**
     Registers the cell for the `UICollectionView` instance.
     
     The cell has to conform to `ReusableView` protocol.
     
     - SeeAlso: `ReusableView`
     
     - parameter type: The cell type
     */
    public func registerCell<T where T: UICollectionViewCell, T: ReusableView>(type: T.Type) {
        self.registerNib(T.nib, forCellWithReuseIdentifier: T.identifier)
    }
    
    /**
     Registers the cell for the `UICollectionView` instance.
     
     - parameter type: The cell type
     */
    public func registerCell<T where T: UICollectionViewCell>(type: T.Type) {
        self.registerClass(T.self, forCellWithReuseIdentifier: String(T))
    }
}