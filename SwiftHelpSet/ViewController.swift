//
//  ViewController.swift
//  SwiftHelpSet
//
//  Created by Luca D'Alberti on 7/14/16.
//  Copyright © 2016 dalu93. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var i = 0
        Each(1).seconds.perform {
            i += 1
            
            print("# \(i)")
            
            return i == 10
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let tableController = SwiftyGenericTableViewController<TableCell, String>()
        
        tableController.enableRefreshControl = true
        
        _ = tableController.cellForModel { cell, model in
            cell.set(title: model)
            return cell
        }.onSelection { indexPath, model in
            self.pushDetailWith(model: model, controller: tableController.navigationController)
        }
        
        tableController.dataSource = [
            "First",
            "Second",
            "Third"
        ]
        
        self.present(tableController, animated: true, completion: nil)
    }
    
    func pushDetailWith(model: String, controller: UINavigationController?) {
        let detailVC = DetailViewController()
        detailVC.model = model
        
        controller?.pushViewController(detailVC, animated: true)
    }
}

final class DetailViewController: UIViewController {
    var model: String? = nil
}

final class TableCell: UITableViewCell {
    
    @IBOutlet private weak var button: UIButton!
    
    func set(title: String) {
        button.setTitle(title, for: .normal)
    }
}

extension TableCell: ReusableView {
    
    static var nibName: String { return "TableCell" }
    static var identifier: String { return "TableCell" }
}

