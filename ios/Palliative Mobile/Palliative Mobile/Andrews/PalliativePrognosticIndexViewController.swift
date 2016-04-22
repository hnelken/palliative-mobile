//
//  PalliativePrognosticIndexViewController.swift
//  Palliative Mobile
//
//  Created by Andrew Marmorstein on 4/9/16.
//  Copyright © 2016 CWRU-SP16. All rights reserved.
//

import UIKit

class PalliativePrognosticIndexViewController: UIViewController {
    
    @IBOutlet weak var palliativePerformanceScale: UIButton!
    @IBOutlet weak var oralIntake: UIButton!
    @IBOutlet weak var edema: UIButton!
    @IBOutlet weak var dyspneaAtRest: UIButton!
    @IBOutlet weak var delirium: UIButton!
    
    @IBOutlet weak var score: UILabel!
    
    var palliativePerformanceScaleOptions = [
        "10-20",
        "30-50",
        "≥60"
    ]
    
    var oralIntakeOptions = [
        "Mouthfulls or less",
        "Reduced but more than mouthfulls",
        "Normal"
    ]
    
    var edemaOptions = [
        "Present",
        "Absent"
    ]
    
    var dyspneaAtRestOptions = [
        "Present",
        "Absent"
    ]
    
    var deliriumOptions = [
        "Present",
        "Absent"
    ]
    
    var button1Type = "Palliative Performance Scale"
    var button2Type = "Oral Intake"
    var button3Type = "Edema"
    var button4Type = "Dyspnea at rest"
    var button5Type = "Delirium"
    
    var button1 = "Palliative Performance Scale"
    var button2 = "Oral Intake"
    var button3 = "Edema"
    var button4 = "Dyspnea at rest"
    var button5 = "Delirium"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        palliativePerformanceScale.setTitle(button1Type, forState: UIControlState.Normal)
        palliativePerformanceScale.hidden = false
        oralIntake.setTitle(button2Type, forState: UIControlState.Normal)
        oralIntake.hidden = true
        edema.setTitle(button3Type, forState: UIControlState.Normal)
        edema.hidden = true
        dyspneaAtRest.setTitle(button4Type, forState: UIControlState.Normal)
        dyspneaAtRest.hidden = true
        delirium.setTitle(button5Type, forState: UIControlState.Normal)
        delirium.hidden = true
        
        score.hidden = true
    }
    
    @IBAction func backToHomeSegue(segue:UIStoryboardSegue) {
        palliativePerformanceScale.setTitle(button1, forState: UIControlState.Normal)
        oralIntake.setTitle(button2, forState: UIControlState.Normal)
        edema.setTitle(button3, forState: UIControlState.Normal)
        dyspneaAtRest.setTitle(button4, forState: UIControlState.Normal)
        delirium.setTitle(button5, forState: UIControlState.Normal)
        
        //if all of the buttons have been selected then it should calculate the score
        if button5 != button5Type
        {
            score.text = getScoreLabel(getScore())
            score.numberOfLines = 0
            score.hidden = false
        }
        else
        {
            score.hidden = true
        }
    }


    @IBAction func palliativePerformanceButton(sender: AnyObject) {
    }
    
    @IBAction func oralIntakeButton(sender: AnyObject) {
    }
    
    @IBAction func edemaButton(sender: AnyObject) {
    }
    
    @IBAction func dyspneaAtRestButton(sender: AnyObject) {
    }
    
    @IBAction func deliriumButton(sender: AnyObject) {
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let id = segue.identifier
        
        if let vc = segue.destinationViewController as? PalliativePrognosticIndexSelectionViewController {
        
            if id == "palliativePerformanceScale"
            {
                vc.options = palliativePerformanceScaleOptions
                vc.button = 1
                vc.selection = button1Type
            }
            else if id == "oralIntake"
            {
                vc.options = oralIntakeOptions
                vc.button = 2
                vc.selection = button2Type
            }
            else if id == "edema"
            {
                vc.options = edemaOptions
                vc.button = 3
                vc.selection = button3Type
            }
            else if id == "dyspneaAtRest"
            {
                vc.options = dyspneaAtRestOptions
                vc.button = 4
                vc.selection = button4Type
            }
            else if id == "delerium"
            {
                vc.options = deliriumOptions
                vc.button = 5
                vc.selection = button5Type
            }
        }
        else {
            // Going home
        }
        
    }
    
    func getScore() -> Double {
        
        var totalScore = 0.0;
        
        //get score for button 1
        switch button1 {
        case palliativePerformanceScaleOptions[0] :
            totalScore += 4
        case palliativePerformanceScaleOptions[1] :
            totalScore += 2.5
        default :
            totalScore += 0
        }
        
        //get score for button 2
        switch button2 {
        case oralIntakeOptions[0] :
            totalScore += 2.5
        case oralIntakeOptions[1] :
            totalScore += 1
        default :
            totalScore += 0
        }
        
        //get score for button 3
        switch button3 {
        case edemaOptions[0] :
            totalScore += 1
        default :
            totalScore += 0
        }
        
        //get score for button 4
        switch button5 {
        case dyspneaAtRestOptions[0] :
            totalScore += 3.5
        default :
            totalScore += 0
        }
        
        //get score for button 5
        switch button5 {
        case deliriumOptions[0] :
            totalScore += 4
        default :
            totalScore += 0
        }
        
        return totalScore
    }
    
    func getScoreLabel(ppiScore : Double) -> String {
        
        if ppiScore > 6 {
             return "PPI score: " + "\(ppiScore)" + ", expected survival shorter than 3 weeks"
        }
        else if ppiScore >= 4 {
            return "PPI score: " + "\(ppiScore)" + ", expected survival shorter than 6 weeks"
        }
        else {
            return "PPI score: " + "\(ppiScore)" + ", expected survival more than 6 weeks"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}



























