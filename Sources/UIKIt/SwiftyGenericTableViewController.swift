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
public class SwiftyGenericTableViewController<C, D where
    C: ReusableView, C: UITableViewCell>: UIViewController {
    
    // MARK: - Properties
    /// The tableView dataSource.
    /// Every time this property will be set, the `tableView.reloadData()` will 
    /// be called. You can override this behavior by overriding the `onDataSourceChange` variable
    public var dataSource: [D]? {
        didSet {
            
            if enableRefreshControl { _refreshControl.endRefreshing() }
            
            guard let onDataSourceChange = self.onDataSourceChange else {
                tableView.reloadData()
                return
            }
            
            onDataSourceChange()
        }
    }
    
    /// Enable refresh control or not
    public var enableRefreshControl: Bool = false
    
    private lazy var _refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(
            self,
            action: #selector(SwiftyGenericTableViewController._refresh),
            forControlEvents: .ValueChanged
        )
        
        return refreshControl
    }()
    
    /// It is called everytime the user refresh the UITableView using a UIRefreshControl.
    ///
    /// It is recommended to update the dataSource here
    public var onRefresh: (() -> ())?
    
    /// Closure responsible for the UITableViewCell creation
    public var cellForModel: ((C, D) -> UITableViewCell)?
    
    /// This closure is called every time the `dataSource` property is set.
    ///
    /// Override it to disable the default behavior: `tableView.reloadData()`
    public var onDataSourceChange: (() -> ())?
    
    /// Selection closure definition
    public typealias TableViewCellSelectionClosure = (indexPath: NSIndexPath, model: D) -> ()
    
    /// This closure is called whenever a cell is selected.
    public var onSelection: TableViewCellSelectionClosure?
    
    /// `SwiftyTableView` instance
    public let tableView = SwiftyTableView(
        frame: .zero,
        style: .Plain
    )
    
    // MARK: - Lifecycle
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        _setupTable()
        _setupUI()
    }
    
    func _refresh() {
        onRefresh?()
    }
}

// MARK: - Helpers
private extension SwiftyGenericTableViewController {
    
    func _setupUI() {
        
        view.addSubview(tableView)
        tableView.pinToSuperView(edge: .all)
        tableView.setupAutomaticDimension()
        if enableRefreshControl { tableView.addSubview(_refreshControl) }
    }
    
    func _setupTable() {
        
        tableView.registerNib(
            C.nib,
            forCellReuseIdentifier: C.identifier
        )
        
        tableView.configureNumberOfSections = {
            return 1
        }
        
        tableView.numberOfRowsPerSection = { [weak self] _ in
            return self?.dataSource?.count ?? 0
        }
        
        tableView.cellForIndexPath = { [weak self] indexPath, tableView in
            guard let cellBuilder = self?.cellForModel,
                let model = self?.dataSource?.get(at: indexPath.row) else { return UITableViewCell() }
            
            let cell: C = tableView.dequeueReusableCell()
            return cellBuilder(cell, model)
        }
        
        tableView.onCellSelection = { [weak self] indexPath in
            
            guard
                let `self` = self,
                let selectedModel = self.dataSource?.get(at: indexPath.row) else { return }
            
            self.onSelection?(indexPath: indexPath, model: selectedModel)
        }
    }
}