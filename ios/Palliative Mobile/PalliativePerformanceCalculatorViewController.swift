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
    
    var button1 = "Ambulation"
    var button2 = "Activity & Evidence of Disease"
    var button3 = "Self-Care"
    var button4 = "Intake"
    var button5 = "Conscious Level"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ambulation.setTitle(button1, forState: UIControlState.Normal)
        ambulation.hidden = false
        activity.setTitle(button2, forState: UIControlState.Normal)
        activity.hidden = true
        selfCare.setTitle(button3, forState: UIControlState.Normal)
        selfCare.hidden = true
        intake.setTitle(button4, forState: UIControlState.Normal)
        intake.hidden = true
        conscious.setTitle(button5, forState: UIControlState.Normal)
        conscious.hidden = true
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func palliativePerformanceCalulatorSegue(segue:UIStoryboardSegue) {
        ambulation.setTitle(button1, forState: UIControlState.Normal)
        activity.setTitle(button2, forState: UIControlState.Normal)
        selfCare.setTitle(button3, forState: UIControlState.Normal)
        intake.setTitle(button4, forState: UIControlState.Normal)
        conscious.setTitle(button5, forState: UIControlState.Normal)
        
        
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
        
        //let segue: String = segue.identifier!
        
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
        
//        if id == "ambulation" || id == "activity" || id == "selfCare" || id == "intake" || id == "consious"
//        {
//            let vc = segue.destinationViewController 
//            
//            let controller = vc.popoverPresentationController
//            
//            if controller != nil
//            {
//                controller?.delegate = self
//            }
//        }
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
