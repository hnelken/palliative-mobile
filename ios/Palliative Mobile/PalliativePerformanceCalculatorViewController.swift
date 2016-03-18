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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ambulation.setTitle("ambuation", forState: UIControlState.Normal)
        activity.setTitle("Activity & Evidence of Disease", forState: UIControlState.Normal)
        selfCare.setTitle("Self-Care", forState: UIControlState.Normal)
        intake.setTitle("Intake", forState: UIControlState.Normal)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ambulation(sender: AnyObject) {
        self.performSegueWithIdentifier("ambulation", sender: self)
        
    }
    
    @IBAction func activity(sender: AnyObject) {
        self.performSegueWithIdentifier("activity", sender: self)
    }
    
    @IBAction func selfCare(sender: AnyObject) {
        self.performSegueWithIdentifier("selfCare", sender: self)
    }
    
    @IBAction func intake(sender: AnyObject) {
        self.performSegueWithIdentifier("intake", sender: self)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        //let segue: String = segue.identifier!
        
        let id = segue.identifier
        
        if id == "ambulation" || id == "activity" || id == "selfCare" || id == "intake"
        {
            let vc = segue.destinationViewController 
            
            let controller = vc.popoverPresentationController
            
            if controller != nil
            {
                controller?.delegate = self
            }
        }
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
