//
//  SurveyViewController.swift
//  Palliative Mobile
//
//  Created by Harry Nelken on 4/10/16.
//  Copyright © 2016 CWRU-SP16. All rights reserved.
//

import UIKit

class SurveyViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    var certifications: [String] = specialties
    var practiceSettings: [String] = settings
    var postGradText: String = "Post-graduate year: "
    var pickingCert: Bool = true
    var picking: Bool = false
    var selection = 0
    var certSelection = 0
    var pracSelection = 0
    
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
        self.practiceField.delegate = self
        self.certField.delegate = self
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
            if Int(postGradSlider.value) == Int(postGradSlider.minimumValue) {
                postGradLabel.text = "\(postGradText)5 or less"
                return
            }
            else {
                postGradLabel.text = "\(postGradText)\(Int(postGradSlider.value))"
            }
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
//        pickingCert = true
//        selection = certSelection
//        flipSurvey()
    }
    
    @IBAction func practiceFieldTapped(sender: AnyObject) {
        // Flip to picker for practice settings
//        pickingCert = false
//        selection = pracSelection
//        flipSurvey()
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
                certSelection = row
                certField.text = certifications[row]
                certField.endEditing(true)
            }
            else {
                pracSelection = row
                practiceField.text = practiceSettings[row]
                practiceField.endEditing(true)
            }
        }
        else {
            // Flip to show the picker
            picking = true
            pickerView.reloadComponent(0)
            pickerView.selectRow(selection, inComponent: 0, animated: false)
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
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        var labelView: UILabel
        if let label = view as? UILabel {
            labelView = label
        }
        else {
            labelView = UILabel(frame: CGRect(x: 0, y: 0, width: pickerView.frame.width-10, height: 75))
        }
        
        // Customize the label
        if pickingCert {
            labelView.text = certifications[row]
        }
        else {
            labelView.text = practiceSettings[row]
        }
        labelView.font = UIFont(name: "Verdana", size: 12)
        labelView.lineBreakMode = .ByWordWrapping
        labelView.textAlignment = .Center
        labelView.textColor = UIColor.blackColor()
        labelView.numberOfLines = 0
        return labelView
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Commit demographic info to DB with device ID
        let device = (UIDevice.currentDevice().identifierForVendor?.UUIDString)!
        let age = Int(ageSlider.value)
        let postGrad: Bool = postGradSwitch.on
        let years = Int(postGradSlider.value)
        let cert = certField.text!
        let prac = practiceField.text!
        
        db.optIn()
        db.releaseFirstTime()
        print("Took survey - first: \(db.getFirstTimeStatus()) - optOut: \(db.getOptOutStatus())")
        db.commitUserInfo(device, age: age, postGrad: postGrad, years: years, cert: cert, prac: prac)
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
       
        if textField.isEqual(practiceField) {
            // Flip to picker for practice settings
            pickingCert = false
            selection = pracSelection
            flipSurvey()
        }
        else if textField.isEqual(certField) {
            // Flip to picker for practice settings
            pickingCert = true
            selection = certSelection
            flipSurvey()
        }
        
        return false
    }

}
