//
//  OpioidCalcTableViewController.swift
//  Palliative Mobile
//
//  Created by Andrew Marmorstein on 4/12/16.
//  Copyright © 2016 CWRU-SP16. All rights reserved.
//

import UIKit

class OpioidCalcTableViewController: UITableViewController {
    
    var options = []
    
    var button = 0
    
    var buttonLabel = ""

    override func viewDidLoad() {
        super.viewDidLoad()
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
        let cell = tableView.dequeueReusableCellWithIdentifier(kOpioidCellID, forIndexPath: indexPath)
        
        cell.textLabel?.text = options[indexPath.row] as? String
        cell.textLabel?.numberOfLines = 0;
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        buttonLabel = (options[indexPath.row] as? String)!
        
        performSegueWithIdentifier("backToHomeSegue", sender: nil)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let vc = segue.destinationViewController as! OpioidCalcViewController
        
        setButton(buttonLabel, vc: vc)
        
    }
    
    func setButton(newLabel: String, vc: OpioidCalcViewController) {
        
        if button == 1
        {
            vc.button1 = newLabel
            vc.button2 = vc.button2Type
            vc.button3 = vc.button3Type
            
            vc.DossageType.hidden = false
            vc.initialDosage.hidden = false
            vc.newMedication.hidden = true
        }
        if button == 2
        {
            vc.button2 = newLabel
            vc.button3=vc.button3Type
            
            vc.newMedication.hidden = false
        }
        if button == 3
        {
            vc.button3 = newLabel
            
            vc.getDosage.hidden = false
        }
    }
}
































