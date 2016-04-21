//
//  SettingsViewController.swift
//  Palliative Mobile
//
//  Created by Harry Nelken on 4/20/16.
//  Copyright © 2016 CWRU-SP16. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var surveyButton: UIButton!
    @IBOutlet weak var surveyLabel: UILabel!
    @IBOutlet weak var activityLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        activityLabel.hidden = true
        activityIndicator.hidden = true
        
        // If the user has not opted out, assume they have taken the survey
        if !db.getOptOutStatus() {
            // Hide the survey button
            surveyButton.enabled = false
            surveyButton.hidden = true
        }
        else { // Else the user opted out of the survey
            // Offer the survey again
            surveyLabel.hidden = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func updatePressed(sender: AnyObject) {
        // Start activity indicator and get updates
        activityIndicator.hidden = false
        activityIndicator.startAnimating()
        activityLabel.hidden = false
        web.callBack = updateCallback
        web.updatePages()
    }

    @IBAction func takeSurveyPressed(sender: AnyObject) {
        performSegueWithIdentifier(kSurveySegueID, sender: self)
    }
    
    func updateCallback() {
        // Stop activity indicator
        activityIndicator.hidden = true
        activityIndicator.stopAnimating()
        activityLabel.text = "Update complete!"
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
