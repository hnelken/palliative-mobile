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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ambulation.setTitle("ambuation", forState: UIControlState.Normal)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ambulation(sender: AnyObject) {
        
        self.performSegueWithIdentifier("ambulation", sender: self)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "ambulation"
        {
            let vc = segue.destinationViewController 
            
            let controller = vc.popoverPresentationController
            
            if controller != nil
            {
                controller?.delegate = self
            }
        }
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        
        return .None
        
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
