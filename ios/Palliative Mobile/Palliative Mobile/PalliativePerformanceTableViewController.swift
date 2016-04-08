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
        
        performSegueWithIdentifier("backToHomeSegue", sender: nil)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let vc = segue.destinationViewController as! PalliativePerformanceCalculatorViewController
        
        setButton(buttonLabel, vc: vc)
        
    }
    
    //gets the buttons which will be valid options
    func getShowFrom(vc: PalliativePerformanceCalculatorViewController) -> Int {
        
        if button == 1
        {
            return 0
        }
        else if button == 2
        {
            if vc.button1 == vc.ambulationOptions[0] {return 0}
            if vc.button1 == vc.ambulationOptions[1] {return 3}
            if vc.button1 == vc.ambulationOptions[2] {return 5}
            if vc.button1 == vc.ambulationOptions[3] {return 6}
            if vc.button1 == vc.ambulationOptions[4] {return 7}
            else {return 0} // this will never be reached
        }
        else if button == 3
        {
            if vc.button2 == vc.activityOptions[0] {return 0}
            if vc.button2 == vc.activityOptions[1] {return 0}
            if vc.button2 == vc.activityOptions[2] {return 0}
            if vc.button2 == vc.activityOptions[3] {return 0}
            if vc.button2 == vc.activityOptions[4] {return 1}
            if vc.button2 == vc.activityOptions[5] {return 2}
            if vc.button2 == vc.activityOptions[6] {return 3}
            if vc.button2 == vc.activityOptions[7] {return 4}
            else {return 0} // this will never be reached
        }
        else if button == 4
        {
            if vc.button3 == vc.selfCareOptions[0] && (vc.button2 == vc.activityOptions[0] || vc.button2 == vc.activityOptions[1]) {return 0}
            if vc.button3 == vc.selfCareOptions[0] && (vc.button2 == vc.activityOptions[2] || vc.button2 == vc.activityOptions[3]) {return 1}
            if vc.button3 == vc.selfCareOptions[1] {return 1}
            if vc.button3 == vc.selfCareOptions[2] {return 1}
            if vc.button3 == vc.selfCareOptions[3] {return 1}
            if vc.button3 == vc.selfCareOptions[4] {return 2}
            else {return 0} // this will never be reached
        }
        else
        {
            if vc.button4 == vc.intakeOptions[0] {return 0}
            if vc.button4 == vc.intakeOptions[1] && vc.button3 == vc.selfCareOptions[0] {return 0}
            if vc.button4 == vc.intakeOptions[1] && (vc.button3 == vc.selfCareOptions[1] || vc.button3 == vc.selfCareOptions[2]) {return 1}
            if vc.button4 == vc.intakeOptions[1] {return 2}
            if vc.button4 == vc.intakeOptions[2] {return 2}
            if vc.button4 == vc.intakeOptions[3] {return 3}
            else {return 0} // this will bever be reached
        }
    }
    
    //gets the variables that will be avaialable for the user to choose from
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
