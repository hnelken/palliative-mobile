//
//  SelfCareViewController.swift
//  Palliative Mobile
//
//  Created by Andrew Marmorstein on 3/18/16.
//  Copyright © 2016 CWRU-SP16. All rights reserved.
//

import UIKit

class SelfCareViewController: UITableViewController {

    var selfCareOptions = [
        "Full",
        "Occasional assistance necessary",
        "Considerable assistance required",
        "Mainly assistance",
        "Total Care"
    ]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selfCareOptions.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(kSelfCareCellID, forIndexPath: indexPath)
        
        cell.textLabel?.text = selfCareOptions[indexPath.row]
        cell.accessoryType = .DisclosureIndicator
        cell.textLabel?.numberOfLines = 0;
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        // passs the info back
        
        
    }
}
