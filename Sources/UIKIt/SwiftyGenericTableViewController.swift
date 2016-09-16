//
//  SwiftyGenericTableViewController.swift
//  SwiftHelpSet
//
//  Created by Luca D'Alberti on 7/14/16.
//  Copyright © 2016 dalu93. All rights reserved.
//

import UIKit

/// `SwiftyGenericTableViewController` allows you to create with simplicity
/// your `UIViewController` instance with a full screen `SwiftyTableView` instance.
///
/// Define your `UITableViewCell` sub-class as a `ReusableView`
/// conforming class.
/// After that, every changes to the `dataSource` variable will call `reloadData`.
/// You can even handle the tableViewCell selection by assigning a 
/// `TableViewCellSelectionClosure` to `onSelection` variable
/// - SeeAlso: `ReusableView`
public class SwiftyGenericTableViewController<C, D>: UIViewController where C: ReusableView, C: UITableViewCell {
    
    // MARK: - Properties
    /// The tableView dataSource.
    /// Every time this property will be set, the `tableView.reloadData()` will 
    /// be called. You can override this behavior by overriding the `onDataSourceChange` variable
    public var dataSource: [D]? {
        didSet {
            
            if enableRefreshControl { _refreshControl?.endRefreshing() }
            
            guard let onDataSourceChange = self._onDataSourceChange else {
                tableView.reloadData()
                return
            }
            
            onDataSourceChange()
        }
    }
    
    /// Enable refresh control or not
    public var enableRefreshControl: Bool = false
    
    private var _refreshControl: UIRefreshControl? = nil
    
    fileprivate var _onRefresh: (() -> ())?
    /// It is called everytime the user refresh the UITableView using a UIRefreshControl.
    ///
    /// It is recommended to update the dataSource here
    public func onRefresh(closure: @escaping (() -> ())) -> Self {
        _onRefresh = closure
        return self
    }
    
    fileprivate var _cellForModel: ((C, D) -> UITableViewCell)?
    /// Closure responsible for the UITableViewCell creation
    public func cellForModel(closure: @escaping ((C, D) -> UITableViewCell)) -> Self {
        _cellForModel = closure
        return self
    }
    
    fileprivate var _onDataSourceChange: VoidClosure?
    /// This closure is called every time the `dataSource` property is set.
    ///
    /// Override it to disable the default behavior: `tableView.reloadData()`
    public func onDataSourceChange(closure: @escaping VoidClosure) -> Self {
        _onDataSourceChange = closure
        return self
    }
    
    /// Selection closure definition
    public typealias TableViewCellSelectionClosure = (_ indexPath: IndexPath, _ model: D) -> ()
    
    fileprivate var _onSelection: TableViewCellSelectionClosure?
    /// This closure is called whenever a cell is selected.
    public func onSelection(closure: @escaping TableViewCellSelectionClosure) -> Self {
        _onSelection = closure
        return self
    }
    
    /// `SwiftyTableView` instance
    public let tableView = SwiftyTableView(
        frame: .zero,
        style: .plain
    )
    
    // MARK: - Lifecycle
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        _setupTable()
        _setupUI()
    }
}

// MARK: - Helpers
private extension SwiftyGenericTableViewController {
    
    func _setupUI() {
        
        view.addSubview(tableView)
        tableView.pinToSuperView(edge: .all)
        if enableRefreshControl {
            
            _ = tableView.addRefreshControl() { [weak self] in
                self?._refresh()
            }
        }
    }
    
    func _setupTable() {
        
        tableView.register(
            C.nib,
            forCellReuseIdentifier: C.identifier
        )
        
        tableView.setupAutomaticDimension()
        
        _ = tableView
            .configureNumberOfSections {
                return 1
            }.numberOfRowsPerSection { _ in
                return self.dataSource?.count ?? 0
            }.cellForIndexPath {
                guard let cellBuilder = self._cellForModel,
                    let model = self.dataSource?.get(at: $0.row) else { return UITableViewCell() }
                
                let cell: C = self.tableView.dequeueReusableCell()
                return cellBuilder(cell, model)
            }.onCellSelection {
                guard let selectedModel = self.dataSource?.get(at: $0.row) else { return }
                
                self._onSelection?($0, selectedModel)
        }
    }
    
    func _refresh() {
        _onRefresh?()
    }
}
