//
//  KarnofskySelectionViewController.swift
//  Palliative Mobile
//
//  Created by Andrew Marmorstein on 4/21/16.
//  Copyright © 2016 CWRU-SP16. All rights reserved.
//

import UIKit

class KarnofskySelectionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // the title for the selection table
    @IBOutlet weak var selectionLabel: UILabel!
    
    var options = []            // the options that can be selected from
    var button = 0              // the button being selected
    var buttonLabel = ""        // the lebel that will be set for the button on the original calc page
    var showFrom = 0            // where to start showing the options from the list
    var showTo = 0              // where to finsih shwoing the choices from the list
    var selection = ""          // the title of the selection
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        options = getViableOptions()
        selectionLabel.text = selection
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if options.count > 7
        {
            return tableView.frame.size.height / CGFloat(6.3)
        }
        else if options.count < 7 && options.count > 3
        {
            return tableView.frame.size.height / CGFloat(options.count)
        }
        else
        {
            return tableView.frame.size.height / CGFloat(4)
        }
    }
    
    func getViableOptions() -> [String] {
        var newOptionList = [String]()
        for i in showFrom...showTo {
            newOptionList.append(options[i] as! String)
        }
        return newOptionList
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(kKarnofskyCellID, forIndexPath: indexPath)
        
        cell.textLabel?.text = options[indexPath.row] as? String
        cell.textLabel?.numberOfLines = 0;
        cell.textLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        buttonLabel = (options[indexPath.row] as? String)!
        
        performSegueWithIdentifier("backToHomeSegue", sender: nil)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let vc = segue.destinationViewController as? KarnofskyViewController {
            setButton(buttonLabel, vc: vc)
        }
    }
    
    // sets the button lablels in the home calculator page so users can see their previous selecitons
    func setButton(newLabel: String, vc: KarnofskyViewController) {
        
        if button == 1
        {
            vc.button1 = newLabel
            vc.button2 = vc.button2Type
            
            vc.levelOfFunctionalCapacity.hidden = false
            vc.score.hidden = true
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
    
    func getShowTo(vc: KarnofskyViewController) -> Int {
        if button == 1
        {
            return 2
        }
        else
        {
            if vc.button1 == vc.conditions[0] {return 2}
            if vc.button1 == vc.conditions[1] {return 5}
            return (vc.levelsOfFunctionalCapcity.count - 1)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
