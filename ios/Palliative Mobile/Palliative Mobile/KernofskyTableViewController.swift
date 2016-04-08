//
//  KernofskyTableViewController.swift
//  Palliative Mobile
//
//  Created by Andrew Marmorstein on 4/8/16.
//  Copyright © 2016 CWRU-SP16. All rights reserved.
//

import UIKit

class KernofskyTableViewController: UITableViewController {
    
    var options = []
    var button = 0
    var buttonLabel = ""
    var showFrom = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        options = getViableOptions()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func getViableOptions() -> [String] {
        var newOptionList = [String]()
        if button == 1 || button == 2
        {
            for i in showFrom...(showFrom + 2) {
                newOptionList.append(options[i] as! String)
            }
        }
        else
        {
            for i in showFrom...(options.count - 1) {
                newOptionList.append(options[i] as! String)
            }
        }
        return newOptionList
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(kPalliativePerformanceCellID, forIndexPath: indexPath)
        
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
        
        let vc = segue.destinationViewController as! KarnofskyViewController
        
        setButton(buttonLabel, vc: vc)
        
    }
    
    func setButton(newLabel: String, vc: KarnofskyViewController) {
        
        if button == 1
        {
            vc.button1 = newLabel
            vc.button2 = vc.button2Type
            
            vc.levelOfFunctionalCapacity.hidden = false
        }
        else
        {
            vc.button2 = newLabel
        }
    }
    
    func getShowFrom(vc: KarnofskyViewController) -> Int {
        if button == 1
        {
            return 0
        }
        else
        {
            if vc.button1 == vc.conditions[0] {return 0}
            if vc.button1 == vc.conditions[1] {return 3}
            return 6                                        //this is the case when they select the third option for button 1
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
}
