//
//  SurveyViewController.swift
//  Palliative Mobile
//
//  Created by Harry Nelken on 4/10/16.
//  Copyright © 2016 CWRU-SP16. All rights reserved.
//

import UIKit

class SurveyViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    var certifications: [String] = ["Cert. 1", "Cert. 2", "Cert. 3"]
    var practiceSettings: [String] = ["Setting 1", "Setting 2", "Setting 3"]
    var postGradText: String = ""
    var pickingCert: Bool = true
    var picking: Bool = false
    
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var switchLabel: UILabel!
    @IBOutlet weak var postGradLabel: UILabel!
    
    @IBOutlet weak var ageSlider: UISlider!
    @IBOutlet weak var postGradSlider: UISlider!
    
    @IBOutlet weak var postGradSwitch: UISwitch!
   
    @IBOutlet weak var certField: UITextField!
    @IBOutlet weak var practiceField: UITextField!
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var surveyView: UIView!
    
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.pickerView.hidden = true
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ageSliderChanged(sender: AnyObject) {
        // Set label to show age value
        if ageSlider.value == ageSlider.maximumValue {
            ageLabel.text = "Age: 65+"
        }
        else {
            ageLabel.text = "Age: \(Int(ageSlider.value))"
        }
    }
    
    @IBAction func postGradSwitchChanged(sender: AnyObject) {
        if postGradSwitch.on {
            // Switch is on, user is in post-grad
            switchLabel.text = "Yes"
            postGradSlider.maximumValue = 10
            postGradSlider.minimumValue = 1
            
            postGradText = "Post-graduate year: "
            postGradLabel.text = "\(postGradText)\(Int(postGradSlider.value))"
        }
        else {
            // Switch is off, user is not in post-grad
            switchLabel.text = "No"
            postGradSlider.maximumValue = 35
            postGradSlider.minimumValue = 5
            postGradText = "Years as physician: "
            postGradLabel.text = "\(postGradText)\(Int(postGradSlider.value))"
        }
    }
    
    @IBAction func postGradSliderChanged(sender: AnyObject) {
        
        // Set slider label text to show slider value
        if postGradText == "Years as physician: " {
            if postGradSlider.value == postGradSlider.maximumValue {
                postGradLabel.text = "\(postGradText)35 or more"
                return
            }
            else if Int(postGradSlider.value) == Int(postGradSlider.minimumValue) {
                postGradLabel.text = "\(postGradText)5 or less"
                return
            }
        }
        // If not at ends or displaying post grad year, just show value as integer
        postGradLabel.text = "\(postGradText)\(Int(postGradSlider.value))"
    }
    
    @IBAction func certFieldTapped(sender: AnyObject) {
        // Flip to picker for certifications
        pickingCert = true
        flipSurvey()
    }
    
    @IBAction func practiceFieldTapped(sender: AnyObject) {
        // Flip to picker for practice settings
        pickingCert = false
        flipSurvey()
    }
    
    @IBAction func buttonPressed(sender: AnyObject) {
        // When the "Done/Submit" button is pressed,
        if picking {
            // Flip back to the survey if picking
            flipSurvey()
        }
        else {
            // Or segue to home page and commit submission
            performSegueWithIdentifier(kFinishSurveySegueID, sender: self)
        }
    }
    
    // Flip the view to show/hide the picker view
    private func flipSurvey() {
        // Hide if picking, show if not
        if picking {
            picking = false
            
            // Flip to hide the picker and format the view
            UIView.transitionFromView(pickerView,
                toView: surveyView,
                duration: 0.75,
                options: [.TransitionFlipFromRight, .ShowHideTransitionViews],
                completion: nil)
            button.setTitle("Submit", forState: .Normal)
            
            // Show picker selection in text fields
            let row = pickerView.selectedRowInComponent(0)
            if pickingCert {
                certField.text = certifications[row]
                certField.endEditing(true)
            }
            else {
                practiceField.text = practiceSettings[row]
                practiceField.endEditing(true)
            }
        }
        else {
            // Flip to show the picker
            picking = true
            pickerView.reloadComponent(0)
            UIView.transitionFromView(surveyView,
                toView: pickerView,
                duration: 0.75,
                options: [.TransitionFlipFromRight, .ShowHideTransitionViews],
                completion: nil)
            button.setTitle("Done", forState: .Normal)
        }
    }
    
    // MARK: - PickerView Delegate/Data Source
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        // Show certifications or practice setting types
        if pickingCert {
            return certifications.count
        }
        else {
            return practiceSettings.count
        }
    }
    
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        var choice: String
        if pickingCert {
            choice = certifications[row]
        }
        else {
            choice = practiceSettings[row]
        }
        return NSAttributedString(string: choice,
            attributes: [NSForegroundColorAttributeName : UIColor.whiteColor()])
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Commit demographic info to DB with device ID
        let deviceID = UIDevice.currentDevice().identifierForVendor?.UUIDString
    }
    

}
