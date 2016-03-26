//
//  PalliativePerformanceCalculatorViewController.swift
//  
//
//  Created by Andrew Marmorstein on 3/17/16.
//
//

import UIKit

class PalliativePerformanceCalculatorViewController: UIViewController, UIPopoverPresentationControllerDelegate{

    @IBOutlet weak var ambulation: UIButton!
    @IBOutlet weak var activity: UIButton!
    @IBOutlet weak var selfCare: UIButton!
    @IBOutlet weak var intake: UIButton!
    @IBOutlet weak var conscious: UIButton!
    
    @IBOutlet weak var score: UILabel!
    
    var ambulationOptions = [
        "Full",
        "Reduced",
        "Mainly Sit/Lie",
        "Mainly in Bed",
        "Totally bed bound",
        "Death"
    ]
    
    var activityOptions = [
        "Normal activity & work" + "\n" + "No evidence of disease",
        "Normal activity & work" + "\n" + "Some evidence of disease",
        "Normal activity with Effort" + "\n" + "Some evidence of disease",
        "Unable Normal Job/Work" + "\n" + "Significant disease",
        "Unable hobby/house work" + "\n" + "significant disease",
        "Unable to do any work" + "\n" + "Extensive disease",
        "unable to do most activity" + "\n" + "Extensive disease",
        "unable to do any activity" + "\n" + "Extensive disease"
    ]
    
    var selfCareOptions = [
        "Full",
        "Occasional assistance necessary",
        "Considerable assistance required",
        "Mainly assistance",
        "Total Care"
    ]
    
    var intakeOptions = [
        "Normal",
        "Normal or Reduced",
        "Minimal to sips",
        "Mouth care only",
    ]
    
    var consciousOptions = [
        "Full",
        "Full or Confusion",
        "Full or Drousy +/- Confusion",
        "Drowsy or Coma +/- Confusion"
    ]
    
    var button1Type = "Ambulation"
    var button2Type = "Activity & Evidence of Disease"
    var button3Type = "Self-Care"
    var button4Type = "Intake"
    var button5Type = "Conscious Level"
    
    var button1 = "Ambulation"
    var button2 = "Activity & Evidence of Disease"
    var button3 = "Self-Care"
    var button4 = "Intake"
    var button5 = "Conscious Level"
    
    //table that will be used for caluating the score
    var scoreTracker = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    
    var PPSlevels = ["100%", "90%", "80%", "70%", "60%", "50%", "40%", "30%", "20%", "10%", "0%"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ambulation.setTitle(button1Type, forState: UIControlState.Normal)
        ambulation.hidden = false
        activity.setTitle(button2Type, forState: UIControlState.Normal)
        activity.hidden = true
        selfCare.setTitle(button3Type, forState: UIControlState.Normal)
        selfCare.hidden = true
        intake.setTitle(button4Type, forState: UIControlState.Normal)
        intake.hidden = true
        conscious.setTitle(button5Type, forState: UIControlState.Normal)
        conscious.hidden = true
        
        score.hidden = true
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func palliativePerformanceCalulatorSegue(segue:UIStoryboardSegue) {
        ambulation.setTitle(button1, forState: UIControlState.Normal)
        activity.setTitle(button2, forState: UIControlState.Normal)
        selfCare.setTitle(button3, forState: UIControlState.Normal)
        intake.setTitle(button4, forState: UIControlState.Normal)
        conscious.setTitle(button5, forState: UIControlState.Normal)
        
        if button1 == ambulationOptions[5]
        {
            activity.hidden = true
            
            score.text = PPSlevels[10]
            score.hidden = false
        }
        //if all of the buttons have been selected then it should calculate the score
        else if button5 != button5Type
        {
            score.text = getScore()
            score.hidden = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func ambulation(sender: AnyObject) {
    }
    
    @IBAction func activity(sender: AnyObject) {
    }
    
    @IBAction func selfCare(sender: AnyObject) {
    }
    
    @IBAction func intake(sender: AnyObject) {
    }
    
    @IBAction func conscious(sender: AnyObject) {
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let id = segue.identifier
        
        let vc = segue.destinationViewController as! PalliativePerformanceTableViewController
        
        if id == "ambulation"
        {
            vc.options = ambulationOptions
            vc.button = 1
        }
        else if id == "activity"
        {
            vc.options = activityOptions
            vc.button = 2
        }
        else if id == "selfCare"
        {
            vc.options = selfCareOptions
            vc.button = 3
        }
        else if id == "intake"
        {
            vc.options = intakeOptions
            vc.button = 4
        }
        else if id == "conscious"
        {
            vc.options = consciousOptions
            vc.button = 5
        }
        
        vc.showFrom = vc.getShowFrom(self)
    }
    
    func getScore() -> String {
        
        // bar will keep track of highest up on the table a value should be added
        // this will make sure that it only applies points where it is possible to get a PPS value 
        // the result will be a more accurate score
        var bar = 0
        
        // set score from button 1 (ambulation)
        switch button1 {
        case ambulationOptions[0] :
            // check to see if the bar is lower then the highest loaction of this choice
            // if it is, then rais it to this choice, else dont lower it
            if bar <= 0 {bar = 0}
            // check to make sure the index above the bar before adding points
            for i in 0...2 { if bar <= i {scoreTracker[i]++}}
        case ambulationOptions[1] :
            if bar <= 3 {bar = 3}
            for i in 3...4 {if bar <= i {scoreTracker[i]++}}
        case ambulationOptions[2] :
            // for cases where the option only exists in one index, the bar will always be either lower or the same 
            // this is due to the structure of the table
            bar = 5
            scoreTracker[5]++
        case ambulationOptions[3] :
            bar = 5
            scoreTracker[6]++
        default :
            if bar <= 7 {bar = 7}
            for i in 7...9 {if bar <= i {scoreTracker[i]++}}
        }
        
        // set score from button 2 (activity & eveidence)
        switch button2 {
        case activityOptions[0] :
            bar = 0
            scoreTracker[0]++
        case activityOptions[1] :
            bar = 1
            scoreTracker[1]++
        case activityOptions[2] :
            bar = 2
            scoreTracker[2]++
        case activityOptions[3] :
            bar = 3
            scoreTracker[3]++
        case activityOptions[4] :
            bar = 4
            scoreTracker[4]++
        case activityOptions[5] :
            bar = 5
            scoreTracker[5]++
        case activityOptions[6] :
            bar = 6
            scoreTracker[6]++
        default :
            if bar <= 7 {bar = 7}
            for i in 7...9 {if bar <= i {scoreTracker[i]++}}
        }
        
        // set score from button3 (self care)
        switch button3 {
        case selfCareOptions[0] :
            if bar <= 0 {bar = 0}
            for i in 0...3 {if bar <= i {scoreTracker[i]++}}
        case selfCareOptions[1] :
            bar = 4
            scoreTracker[4]++
        case selfCareOptions[2] :
            bar = 5
            scoreTracker[5]++
        case selfCareOptions[3] :
            bar = 6
            scoreTracker[6]++
        default :
            if bar <= 7 {bar = 7}
            for i in 7...9 {if bar <= i {scoreTracker[i]++}}
        }
        
        // set score from button4 (intake)
        switch button4 {
        case intakeOptions[0] :
            if bar <= 0 {bar = 0}
            for i in 0...1 {if bar <= i {scoreTracker[i]++}}
        case intakeOptions[1] :
            if bar <= 0 {bar = 0}
            for i in 2...7 {if bar <= i {scoreTracker[i]++}}
        case intakeOptions[2] :
            bar = 8
            scoreTracker[8]++
        default :
            bar = 9
            scoreTracker[9]++
        }
        
        // set score from button5 (conscious level)
        switch button5 {
        case consciousOptions[0] :
            if bar <= 0 {bar = 0}
            for i in 0...3 {if bar <= i {scoreTracker[i]++}}
        case consciousOptions[1] :
            if bar <= 4 {bar = 4}
            for i in 4...5 {if bar <= i {scoreTracker[i]++}}
        case consciousOptions[2] :
            if bar <= 6 {bar = 6}
            for i in 6...8 {if bar <= i {scoreTracker[i]++}}
        default :
            bar = 9
            scoreTracker[9]++
        }
        
        
        return PPSlevels[getFinalScoreIndex()]
    }
    
    func getFinalScoreIndex() -> Int {
        
        //take a wieghted average
        var sum = 0
        var divisor = 0
        
        for i in 0..<scoreTracker.count
        {
            sum += (scoreTracker[i] * i)
            divisor += scoreTracker[i]
        }
        
        return sum / divisor
    }

}
