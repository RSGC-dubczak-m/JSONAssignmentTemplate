//
//  scoresListViewController.swift
//  JSON - UI Assignment Scoreboard App
//
//  Created by Student on 2016-05-17.
//  Copyright © 2016 Maxym Dubczak. All rights reserved.
//

import Foundation
import UIKit

class scoresListViewController : UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        cell.textLabel!.text = "Table To Be Filled"
        cell.backgroundColor = UIColor.cyanColor()
        
        return cell
    }
}