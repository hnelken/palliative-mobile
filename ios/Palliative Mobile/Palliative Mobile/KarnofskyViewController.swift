//
//  KarnofskyViewController.swift
//  Palliative Mobile
//
//  Created by Andrew Marmorstein on 3/26/16.
//  Copyright © 2016 CWRU-SP16. All rights reserved.
//

import UIKit

class KarnofskyViewController: UIViewController {

    @IBOutlet weak var condition: UIButton!
    @IBOutlet weak var levelOfFunctionalCapacity: UIButton!
    
    @IBOutlet weak var score: UILabel!
    
    
    var conditions = [
        "Able to carry on normal activity and work; no special care needed",
        "Unable to work; able to live at home and care for most personal needs; varying amount of assitance needed",
        "Unable to care for self; requires equivalent of instatutional or hospital care; diseases may be progressing rapidly"
    ]
    
    var levelsOfFunctionalCpacity = [
        "No complaints, no evidence of disease",
        "Able to carry on normal activity; minor signs or symptoms of disease",
        "Normal activity with effort; some signs or symptoms of disease",
        "Care for self; unable to carry on normal activity or to do active work",
        "Requires occasional assistance but is able to care for most personal needs",
        "Requires considerable assistance and frequent medical care",
        "Disabled; requires special care and assistance",
        "Severely disabled; hospital admission indicated although death not imminent",
        "very sick; hospital admission necessary; active supportive treatment necessary",
        "Moribund; fatal processes progressing rapidly",
        "Death"
    ]
    
    var button1Type = "Condition"
    var button2Type = "Level of Functional Capacity"
    
    var button1 = "Condition"
    var button2 = "level of Functional Capacity"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        condition.setTitle(button1Type, forState: UIControlState.Normal)
        condition.hidden = false
        levelOfFunctionalCapacity.setTitle(button2Type, forState: UIControlState.Normal)
        levelOfFunctionalCapacity.hidden = true

        
    }
    
    @IBAction func karnofskyCalulatorSegue(segue:UIStoryboardSegue) {
        condition.setTitle(button1, forState: UIControlState.Normal)
        levelOfFunctionalCapacity.setTitle(button2, forState: UIControlState.Normal)
                    //if all of the buttons have been selected then it should calculate the score
        if button2 != button2Type
        {
           // score.text = getScore()
            score.hidden = false
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func conditionSegue(sender: AnyObject) {
    }
    
    
    @IBAction func levelSegue(sender: AnyObject) {
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let id = segue.identifier
        
        let vc = segue.destinationViewController
    }

}
