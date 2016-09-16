//
//  SwiftyTableView.swift
//  SwiftHelpSet
//
//  Created by Luca D'Alberti on 7/14/16.
//  Copyright © 2016 dalu93. All rights reserved.
//

import UIKit

public class SwiftyTableView: UITableView {
    
    fileprivate var _configureNumberOfSections: (() -> Int)?
    /// It is called everytime `numberOfSectionsInTableView(tableView: UITableView)` is called
    public func configureNumberOfSections(closure: @escaping (() -> Int)) -> Self {
        _configureNumberOfSections = closure
        return self
    }
    
    fileprivate var _numberOfRowsPerSection: ((_ section: Int) -> Int)?
    /// It is called everytime `tableView(tableView: UITableView, numberOfRowsInSection section: Int)` is called
    public func numberOfRowsPerSection(closure: @escaping ((_ section: Int) -> Int)) -> Self {
        _numberOfRowsPerSection = closure
        return self
    }
    
    fileprivate var _cellForIndexPath: ((_ indexPath: IndexPath) -> UITableViewCell)?
    /// It is called everytime `tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)` is called
    public func cellForIndexPath(closure: @escaping ((_ indexPath: IndexPath) -> UITableViewCell)) -> Self {
        _cellForIndexPath = closure
        return self
    }
    
    fileprivate var _onCellSelection: ((_ indexPath: IndexPath) -> ())?
    /// It is called everytime `tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)` is called
    public func onCellSelection(closure: @escaping ((_ indexPath: IndexPath) -> ())) -> Self {
        _onCellSelection = closure
        return self
    }
    
    fileprivate var _onScroll: ((_ scrollView: UIScrollView) -> ())?
    /// It is called everytime `scrollViewDidScroll(scrollView: UIScrollView)` is called
    public func onScroll(closure: @escaping ((_ scrollView: UIScrollView) -> ())) -> Self {
        _onScroll = closure
        return self
    }
    
    fileprivate var _footerInSection: ((_ section: Int) -> UIView?)?
    /// It is called everytime `tableView(tableView: UITableView, viewForFooterInSection section: Int)` is called
    public func footerInSection(closure: @escaping ((_ section: Int) -> UIView?)) -> Self {
        _footerInSection = closure
        return self
    }
    
    fileprivate var _headerInSection: ((_ section: Int) -> UIView?)?
    /// It is called everytime `tableView(tableView: UITableView, viewForHeaderInSection section: Int)` is called
    public func headerInSection(closure: @escaping ((_ section: Int) -> UIView?)) -> Self {
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
    
    @nonobjc public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return _configureNumberOfSections?() ?? 0
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _numberOfRowsPerSection?(section) ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return _cellForIndexPath?(indexPath) ?? UITableViewCell()
    }
}

// MARK: - UITableViewDelegate
extension SwiftyTableView: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        _onCellSelection?(indexPath)
    }
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return _footerInSection?(section)
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return _headerInSection?(section)
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        _onScroll?(scrollView)
    }
}
