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
        "Able to carry on normal activity and work; \n no special care needed",
        "Unable to work;" + "\n" + "able to live at home and care for most personal needs;" + "\n" + "varying amount of assitance needed",
        "Unable to care for self;" + "\n" + "requires equivalent of instatutional or hospital care;" + "\n" + "diseases may be progressing rapidly"
    ]
    
    var levelsOfFunctionalCapcity = [
        "No complaints, no evidence of disease",
        "Able to carry on normal activity;" +  "\n" + "minor signs or symptoms of disease",
        "Normal activity with effort;" + "\n" + "some signs or symptoms of disease",
        "Care for self;" + "\n" + "unable to carry on normal activity or to do active work",
        "Requires occasional assistance but is able to care for most personal needs",
        "Requires considerable assistance and frequent medical care",
        "Disabled; requires special care and assistance",
        "Severely disabled;" + "\n" + "hospital admission indicated although death not imminent",
        "very sick;" + "\n" + "hospital admission necessary; \n active supportive treatment necessary",
        "Moribund;" + "\n" + "fatal processes progressing rapidly",
        "Death"
    ]
    
    var button1Type = "Condition"
    var button2Type = "Level of Functional Capacity"
    
    var button1 = "Condition"
    var button2 = "level of Functional Capacity"
    
    var value = ["100%", "90%", "80%", "70%", "60%", "50%", "40%", "30%", "20%", "10%", "0%"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        condition.setTitle(button1Type, forState: UIControlState.Normal)
        condition.hidden = false
        levelOfFunctionalCapacity.setTitle(button2Type, forState: UIControlState.Normal)
        levelOfFunctionalCapacity.hidden = true
        
        score.hidden = true
    }
    
    @IBAction func karnofskyCalulatorSegue(segue:UIStoryboardSegue) {
        condition.setTitle(button1, forState: UIControlState.Normal)
        levelOfFunctionalCapacity.setTitle(button2, forState: UIControlState.Normal)
                    //if all of the buttons have been selected then it should calculate the score
        if button2 != button2Type
        {
            score.text = getScore()
            score.hidden = false
        }
        
        condition.titleLabel?.numberOfLines = 0
        condition.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Center
        levelOfFunctionalCapacity.titleLabel?.numberOfLines = 0
        levelOfFunctionalCapacity.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Center
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func condition(sender: AnyObject) {
    }
    
    
    @IBAction func level(sender: AnyObject) {
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let id = segue.identifier
        
        let vc = segue.destinationViewController as! KernofskyTableViewController
        
        if id == "conditionSegue"
        {
            vc.options = conditions
            vc.button = 1
        }
        else
        {
            vc.options = levelsOfFunctionalCapcity
            vc.button = 2
        }
        
        vc.showFrom = vc.getShowFrom(self)
        vc.showTo = vc.getShowTo(self)
    }
    
    func getScore() -> String {
        
        for i in 0..<levelsOfFunctionalCapcity.count
        {
            if button2 == levelsOfFunctionalCapcity[i] {return value[i]}
        }
        
        return "DNR" //this should never be reached
    }

}
