//
//  RapidPCViewController.swift
//  Palliative Mobile
//
//  Created by Harry Nelken on 3/16/16.
//  Copyright © 2016 CWRU-SP16. All rights reserved.
//

import UIKit

class RapidPCViewController: UIViewController {

    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        yesButton.layer.cornerRadius = 15
        noButton.layer.cornerRadius = 15
        yesButton.clipsToBounds = true
        noButton.clipsToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func noButtonPressed(sender: AnyObject) {
        
        performSegueWithIdentifier(kUnstableSegueID, sender: self)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if let destVC = segue.destinationViewController as? ArticleDisplayViewController {
            
            destVC.pageID = 8
        }
    }

}
