//
//  PalliativePerformanceTableViewController.swift
//  Palliative Mobile
//
//  Created by Andrew Marmorstein on 3/19/16.
//  Copyright © 2016 CWRU-SP16. All rights reserved.
//

import UIKit

class PalliativePerformanceTableViewController: UITableViewController {

    var options = []
    
    var button = 0
    
    var buttonLabel = "test"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
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
        return options.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(kPalliativePerformanceCellID, forIndexPath: indexPath)
        
        cell.textLabel?.text = options[indexPath.row] as? String
        cell.accessoryType = .DisclosureIndicator
        cell.textLabel?.numberOfLines = 0;
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        buttonLabel = (options[indexPath.row] as? String)!
        
        performSegueWithIdentifier("backToHomeSegue", sender: nil)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let vc = segue.destinationViewController as! PalliativePerformanceCalculatorViewController
        
        setButton(buttonLabel, vc: vc)
    }
    
    func setButton(newLabel: String, vc: PalliativePerformanceCalculatorViewController) {
        
        if button == 1
        {
            vc.button1 = newLabel
            vc.activity.hidden = false
        }
        else if button == 2
        {
            vc.button2 = newLabel
            vc.selfCare.hidden = false
        }
        else if button == 3
        {
            vc.button3 = newLabel
            vc.intake.hidden = false
        }
        else if button == 4
        {
            vc.button4 = newLabel
            vc.conscious.hidden = false
        }
        else if button == 5
        {
            vc.button5 = newLabel
            
        }
    }

}
