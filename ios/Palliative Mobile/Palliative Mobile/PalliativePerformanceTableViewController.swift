//
//  PalliativePerformanceTableViewController.swift
//  Palliative Mobile
//
//  Created by Andrew Marmorstein on 3/19/16.
//  Copyright © 2016 CWRU-SP16. All rights reserved.
//

import UIKit

class PalliativePerformanceTableViewController: UITableViewController {

    //the options to choose from
    var options = []
    
    //the button that the selection is being made for
    var button = 0
    
    //a place holder for the name that is going to be set for the button
    //the text will always be changed before use
    var buttonLabel = "if you can see this I messed up"
    
    // a counter which will indicate wich variables are able to be used
    var showFrom = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        options = getViableOptions(options as! [String])
        
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
        cell.textLabel?.numberOfLines = 0;
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        buttonLabel = (options[indexPath.row] as? String)!
        
        showFrom = indexPath.row
        
        performSegueWithIdentifier("backToHomeSegue", sender: nil)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let vc = segue.destinationViewController as! PalliativePerformanceCalculatorViewController
        
        setButton(buttonLabel, vc: vc)
        
        vc.showFrom = showFrom
        
    }
    
    func getViableOptions(optionList: [String]) -> [String] {
        var newOptionList = [String]()
        for index in showFrom...(optionList.count - 1){
            newOptionList.append(options[index] as! String)
        }
        return newOptionList
    }
    
    //method which sets the buttons in the calculator based off your selection
    func setButton(newLabel: String, vc: PalliativePerformanceCalculatorViewController) {
        
        if button == 1
        {
            //sets the name of the button to the selection and reverts the lower buttons if need be
            vc.button1 = newLabel
            vc.button2 = vc.button2Type
            vc.button3 = vc.button3Type
            vc.button4 = vc.button4Type
            vc.button5 = vc.button5Type
            
            //hides all buttons but the one selected and the one below
            vc.activity.hidden = false
            vc.selfCare.hidden = true
            vc.intake.hidden = true
            vc.conscious.hidden = true
            
        }
        else if button == 2
        {
            vc.button2 = newLabel
            vc.button3 = vc.button3Type
            vc.button4 = vc.button4Type
            vc.button5 = vc.button5Type
            
            vc.selfCare.hidden = false
            vc.intake.hidden = true
            vc.conscious.hidden = true
        }
        else if button == 3
        {
            vc.button3 = newLabel
            vc.button4 = vc.button4Type
            vc.button5 = vc.button5Type
            
            vc.intake.hidden = false
            vc.conscious.hidden = true
        }
        else if button == 4
        {
            vc.button4 = newLabel
            vc.button5 = vc.button5Type
            
            vc.conscious.hidden = false
        }
        else if button == 5
        {
            vc.button5 = newLabel
            
        }
    }

}
