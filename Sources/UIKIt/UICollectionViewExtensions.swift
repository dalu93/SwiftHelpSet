//
//  UICollectionViewExtensions.swift
//  SwiftHelpSet
//
//  Created by Luca D'Alberti on 7/29/16.
//  Copyright © 2016 dalu93. All rights reserved.
//

import UIKit

public extension UICollectionView {
    
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
    public func dequeueReusableCell<T>(at indexPath: IndexPath) -> T where T: UICollectionViewCell, T: ReusableView {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as? T else { fatalError("A cell with \(T.identifier) identifier cannot be dequeued") }
        
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
    public func dequeueReusableCell<T>(at indexPath: IndexPath) -> T where T: UICollectionViewCell {
        let identifier = String(describing: T.self)
        
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? T else { fatalError("A cell with \(identifier) identifier cannot be dequeued") }
        
        return cell
    }
    
    /**
     Registers the cell for the `UICollectionView` instance.
     
     The cell has to conform to `ReusableView` protocol.
     
     - SeeAlso: `ReusableView`
     
     - parameter type: The cell type
     */
    public func registerCell<T>(type: T.Type) where T: UICollectionViewCell, T: ReusableView {
        self.register(T.nib, forCellWithReuseIdentifier: T.identifier)
    }
    
    /**
     Registers the cell for the `UICollectionView` instance.
     
     - parameter type: The cell type
     */
    public func registerCell<T>(type: T.Type) where T: UICollectionViewCell {
        self.register(T.self, forCellWithReuseIdentifier: String(describing: T.self))
    }
    
    /**
     Reload the `UICollectionView` instance and perform a block when the reload
     is completed
     
     - parameter completion: Block to perform after the `UICollectionView` finishes
                             to reload
     */
    public func reloadData(completion: @escaping () -> ()) {
        self.reloadData()
        self.performBatchUpdates(nil) { _ in
            completion()
        }
    }
}
