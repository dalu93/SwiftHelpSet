//
//  SwiftyTableView.swift
//  SwiftHelpSet
//
//  Created by Luca D'Alberti on 7/14/16.
//  Copyright © 2016 dalu93. All rights reserved.
//

import UIKit

public class SwiftyTableView: UITableView {
    
    /// It is called everytime `numberOfSectionsInTableView(tableView: UITableView)` is called
    public var configureNumberOfSections: (() -> Int)?
    
    /// It is called everytime `tableView(tableView: UITableView, numberOfRowsInSection section: Int)` is called
    public var numberOfRowsPerSection: ((section: Int) -> Int)?
    
    /// It is called everytime `tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)` is called
    public var cellForIndexPath: ((indexPath: NSIndexPath, tableView: UITableView) -> UITableViewCell)?
    
    /// It is called everytime `tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)` is called
    public var onCellSelection: ((indexPath: NSIndexPath) -> ())?
    
    /// It is called everytime `scrollViewDidScroll(scrollView: UIScrollView)` is called
    public var onScroll: ((scrollView: UIScrollView) -> ())?
    
    /// It is called everytime `tableView(tableView: UITableView, viewForFooterInSection section: Int)` is called
    public var footerInSection: ((section: Int) -> UIView?)?
    
    /// It is called everytime `tableView(tableView: UITableView, viewForHeaderInSection section: Int)` is called
    public var headerInSection: ((section: Int) -> UIView?)?
    
    override public init(frame: CGRect, style: UITableViewStyle) {
        super.init(
            frame: frame,
            style: style
        )
        _setupProtocols()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(
            coder: aDecoder
        )
        _setupProtocols()
    }
}

// MARK: - Helpers
private extension SwiftyTableView {
    
    func _setupProtocols() {
        
        self.delegate = self
        self.dataSource = self
    }
}

// MARK: - UITableViewDataSource
extension SwiftyTableView: UITableViewDataSource {
    
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return configureNumberOfSections?() ?? 0
    }
    
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRowsPerSection?(section: section) ?? 0
    }
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return cellForIndexPath?(indexPath: indexPath, tableView: tableView) ?? UITableViewCell()
    }
}

// MARK: - UITableViewDelegate
extension SwiftyTableView: UITableViewDelegate {
    
    public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        onCellSelection?(indexPath: indexPath)
    }
    
    public func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return footerInSection?(section: section)
    }
    
    public func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerInSection?(section: section)
    }
    
    public func scrollViewDidScroll(scrollView: UIScrollView) {
        onScroll?(scrollView: scrollView)
    }
}