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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let tableController = SwiftyGenericTableViewController<TableCell, String>()
        
        tableController.enableRefreshControl = true
        
        tableController.cellForModel = { cell, model in
            cell.set(title: model)
            return cell
        }
        
        tableController.dataSource = [
            "First",
            "Second",
            "Third"
        ]
        
        tableController.onSelection = { [weak self] indexPath, model in
            let alert = UIAlertController(title: "Touched", message: "Selected row \(indexPath.row)", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .Cancel, handler: nil))
            
            self?.presentViewController(alert, animated: true, completion: nil)
        }
        
        self.presentViewController(tableController, animated: true, completion: nil)
    }
}

final class TableCell: UITableViewCell {
    
    @IBOutlet private weak var button: UIButton!
    
    func set(title title: String) {
        button.setTitle(title, forState: .Normal)
    }
}

extension TableCell: ReusableView {
    
    static var nibName: String { return "TableCell" }
    static var identifier: String { return "TableCell" }
}

