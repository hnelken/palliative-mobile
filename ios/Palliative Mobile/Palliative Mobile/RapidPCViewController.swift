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
    
    var titleText = "UNSTABLE patient"
    var subtitleText = "Rapid screen for those on EOL trajectory"
    var content = "For unstable patients use most resuscitative measures until you have more information. Ask yourself: “How do I reverse life threat as usual (ABCs, VS)?” ...but also ask yourself: “Does patient have cachexia, contractures, open wounds?” (b4 screen: relieve critical/unstable distress. 1st decrease suffering, stress, and anxiety for both the patient and family caregivers. In addition to considering how symptom-related suffering can be made better, consider how  underlying condition can be made better. The clinical condition may warrant antibiotics for infection, anticoagulation for thromboembolism, or intravenous fluids for dehydration. Careful attention must be paid when death is imminent. Goals of care must be assessed to determine the most appropriate next step for making things better, especially whether attempts for disease modification are warranted."
    
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
            
            destVC.titleText = titleText
            destVC.subtitleText = subtitleText
            destVC.descriptionText = content
        }
    }

}
