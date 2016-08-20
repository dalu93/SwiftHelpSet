//
//  SwiftyTableView.swift
//  SwiftHelpSet
//
//  Created by Luca D'Alberti on 7/14/16.
//  Copyright © 2016 dalu93. All rights reserved.
//

import UIKit

public class SwiftyTableView: UITableView {
    
    private var _configureNumberOfSections: (() -> Int)?
    /// It is called everytime `numberOfSectionsInTableView(tableView: UITableView)` is called
    public func configureNumberOfSections(closure: () -> Int) -> Self {
        _configureNumberOfSections = closure
        return self
    }
    
    private var _numberOfRowsPerSection: ((section: Int) -> Int)?
    /// It is called everytime `tableView(tableView: UITableView, numberOfRowsInSection section: Int)` is called
    public func numberOfRowsPerSection(closure: (section: Int) -> Int) -> Self {
        _numberOfRowsPerSection = closure
        return self
    }
    
    private var _cellForIndexPath: ((indexPath: NSIndexPath) -> UITableViewCell)?
    /// It is called everytime `tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)` is called
    public func cellForIndexPath(closure: (indexPath: NSIndexPath) -> UITableViewCell) -> Self {
        _cellForIndexPath = closure
        return self
    }
    
    private var _onCellSelection: ((indexPath: NSIndexPath) -> ())?
    /// It is called everytime `tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)` is called
    public func onCellSelection(closure: (indexPath: NSIndexPath) -> ()) -> Self {
        _onCellSelection = closure
        return self
    }
    
    private var _onScroll: ((scrollView: UIScrollView) -> ())?
    /// It is called everytime `scrollViewDidScroll(scrollView: UIScrollView)` is called
    public func onScroll(closure: (scrollView: UIScrollView) -> ()) -> Self {
        _onScroll = closure
        return self
    }
    
    private var _footerInSection: ((section: Int) -> UIView?)?
    /// It is called everytime `tableView(tableView: UITableView, viewForFooterInSection section: Int)` is called
    public func footerInSection(closure: (section: Int) -> UIView?) -> Self {
        _footerInSection = closure
        return self
    }
    
    private var _headerInSection: ((section: Int) -> UIView?)?
    /// It is called everytime `tableView(tableView: UITableView, viewForHeaderInSection section: Int)` is called
    public func headerInSection(closure: (section: Int) -> UIView?) -> Self {
        _headerInSection = closure
        return self
    }
    
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
        return _configureNumberOfSections?() ?? 0
    }
    
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _numberOfRowsPerSection?(section: section) ?? 0
    }
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return _cellForIndexPath?(indexPath: indexPath) ?? UITableViewCell()
    }
}

// MARK: - UITableViewDelegate
extension SwiftyTableView: UITableViewDelegate {
    
    public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        _onCellSelection?(indexPath: indexPath)
    }
    
    public func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return _footerInSection?(section: section)
    }
    
    public func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return _headerInSection?(section: section)
    }
    
    public func scrollViewDidScroll(scrollView: UIScrollView) {
        _onScroll?(scrollView: scrollView)
    }
}