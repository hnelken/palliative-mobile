//
//  PalliativePrognosticIndexSelectionViewController.swift
//  Palliative Mobile
//
//  Created by Andrew Marmorstein on 4/21/16.
//  Copyright © 2016 CWRU-SP16. All rights reserved.
//

import UIKit

class PalliativePrognosticIndexSelectionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var selectionLabel: UILabel!

    //the options to choose from
    var options = []
    
    //the button that the selection is being made for
    var button = 0
    
    //place holder for the name it will set for the button on the main calculator screen
    var buttonLabel = ""
    
    var selection = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectionLabel.text = selection
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
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
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(kPalliativePrognosticIndexCellID, forIndexPath: indexPath)
        
        cell.textLabel?.text = options[indexPath.row] as? String
        cell.textLabel?.numberOfLines = 0;
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        buttonLabel = (options[indexPath.row] as? String)!
        
        performSegueWithIdentifier("backToHomeSegue", sender: nil)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let vc = segue.destinationViewController as! PalliativePrognosticIndexViewController
        
        setButton(buttonLabel, vc: vc)
        
    }
    
    //method which sets the buttons in the calculator based off your selection
    func setButton(newLabel: String, vc: PalliativePrognosticIndexViewController) {
        
        if button == 1
        {
            //sets the name of the button to the selection and reverts the lower buttons if need be
            vc.button1 = newLabel
            vc.button2 = vc.button2Type
            vc.button3 = vc.button3Type
            vc.button4 = vc.button4Type
            vc.button5 = vc.button5Type
            
            //hides all buttons but the one selected and the one below
            vc.oralIntake.hidden = false
            vc.edema.hidden = true
            vc.dyspneaAtRest.hidden = true
            vc.delirium.hidden = true
            
        }
        else if button == 2
        {
            vc.button2 = newLabel
            vc.button3 = vc.button3Type
            vc.button4 = vc.button4Type
            vc.button5 = vc.button5Type
            
            vc.edema.hidden = false
            vc.dyspneaAtRest.hidden = true
            vc.delirium.hidden = true
        }
        else if button == 3
        {
            vc.button3 = newLabel
            vc.button4 = vc.button4Type
            vc.button5 = vc.button5Type
            
            vc.dyspneaAtRest.hidden = false
            vc.delirium.hidden = true
        }
        else if button == 4
        {
            vc.button4 = newLabel
            vc.button5 = vc.button5Type
            
            vc.delirium.hidden = false
        }
        else if button == 5
        {
            vc.button5 = newLabel
            
        }
    }

}
