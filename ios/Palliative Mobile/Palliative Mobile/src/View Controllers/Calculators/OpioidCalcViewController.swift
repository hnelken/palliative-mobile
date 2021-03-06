//
//  OpioidCalcViewController.swift
//  Palliative Mobile
//
//  Created by Andrew Marmorstein on 4/12/16.
//  Copyright © 2016 CWRU-SP16. All rights reserved.
//

import UIKit

class OpioidCalcViewController: UIViewController, UITextFieldDelegate {

    // buttons for the calculator
    @IBOutlet weak var initialMedication: UIButton!
    @IBOutlet weak var newMedication: UIButton!
    @IBOutlet weak var getDosage: UIButton!
    @IBOutlet weak var DossageType: UIButton!
    
    // text fireld for initial dosage
    @IBOutlet weak var initialDosage: UITextField!
    
    // label that will give the calculated dosage
    @IBOutlet weak var dosage: UILabel!
    
    var medications = [
        "Morphine Sulfate",
        "Codeine",
        "Hydrocodone",
        "Hydromorphone",
        "Oxycodone",
        "Oxymorphone"
    ]
    
    var medicationsIV_SC = [
        "Morphine Sulfate",
        "Codeine",
        "Hydromorphone",
        "Oxymorphone"
    ]
    
    var medicationsPO = [
        "Morphine Sulfate",
        "Codeine",
        "Hydrocodone",
        "Hydromorphone",
        "Oxycodone",
        "Oxymorphone"
    ]
    
    var medicationsPR = [
        "Morphine Sulfate",
        "Codeine",
        "Hydromorphone"
    ]
    
    // there is a struct for each medication
    // the information is eveything needed for calculations
    struct MorphineSulfate {
        var dosageTypes = [
            "IV/SC",
            "PO",
            "PR"
        ]
        var iv_sc = 10.0
        var po = 30.0
        var pr = 30.0
    }
    
    struct Codeine {
        var dosageTypes = [
            "IV/SC",
            "PO",
            "PR"
        ]
        var iv_sc = 120.0
        var po = 200.0
        var pr = 200.0
    }
    
    struct Hydrocodone {
        var dosageTypes = [
            "PO"
        ]
        var po = 30.0
    }
    
    struct Hydromorphone {
        var dosageTypes = [
            "IV/SC",
            "PO",
            "PR"
        ]
        var iv_sc = 1.5
        var po = 6.0
        var pr = 6.0
    }
    
    struct Oxycodone {
        var dosageTypes = [
            "PO"
        ]
        var po = 20.0
    }
    
    struct Oxymorphone {
        var dosageTypes = [
            "IV/SC",
            "PO"
        ]
        var iv_sc = 1.0
        var po = 10.0
    }
    
    // buttons which store the type of each button
    var button1Type = "Current Medication"
    var button2Type = "Dosage Type"
    var button3Type = "New Medication"
    
    // buttons which store the election made for each button
    var button1 = "Current Medication"
    var button2 = "Dosage Type"
    var button3 = "New Medication"
    
    var dosageLabel = ""
    
    private let parentID = 225
    private var bookmarked: Bool = false
    
    @IBOutlet weak var bookmarkButton: UIButton!
    
    @IBAction func backPressed(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func navUpPressed(sender: AnyObject) {
        let vc = storyboard?.instantiateViewControllerWithIdentifier("articleViewController") as! ArticleDisplayViewController
        
        vc.pageID = parentID
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func bookmarkPressed(sender: AnyObject) {
        
        // Change bookmark status (visual and in DB)
        if !bookmarked {
            bookmarkButton.setBackgroundImage(UIImage(named: "bookmark-red"), forState: .Normal)
            bookmarked = true
        }
        else {
            bookmarkButton.setBackgroundImage(UIImage(named: "bookmark-white"), forState: .Normal)
            bookmarked = false
        }
        
        db.commitBookmarkChanges(bookmarked, pageID: kOpioidPageID)
    }
    
    override func viewWillAppear(animated: Bool) {
        bookmarked = db.isPageBookmarked(kOpioidPageID)
        
        // Set bookmark button view
        if bookmarked {
            bookmarkButton.setBackgroundImage(UIImage(named: "bookmark-red"), forState: .Normal)
        }
        else {
            bookmarkButton.setBackgroundImage(UIImage(named: "bookmark-white"), forState: .Normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialMedication.setTitle(button1Type, forState: UIControlState.Normal)
        DossageType.setTitle(button2Type, forState: UIControlState.Normal)
        newMedication.setTitle(button3Type, forState: UIControlState.Normal)
        
        DossageType.hidden = true
        newMedication.hidden = true
        getDosage.hidden = true
        initialDosage.hidden = true
        dosage.hidden = true
        
        // Add tap to dismiss keyboard
        initialDosage.delegate = self
        let tap = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @IBAction func backToHomeSegue(segue:UIStoryboardSegue) {
        initialMedication.setTitle(button1, forState: UIControlState.Normal)
        DossageType.setTitle(button2, forState: UIControlState.Normal)
        newMedication.setTitle(button3, forState: UIControlState.Normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func InitialMedication(sender: AnyObject) {
    }
    
    @IBAction func DosageType(sender: AnyObject) {
    }
    
    @IBAction func NewMedication(sender: AnyObject) {
    }
    
    @IBAction func getDossageButton(sender: AnyObject) {
        setDosageLabel()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let id = segue.identifier
        
        if let vc = segue.destinationViewController as? OpiodCalculatorSelectionViewController {
            if id == "initialMedicationSegue"
            {
                vc.options = medications
                vc.button = 1
                vc.selection = button1Type
            }
            else if id == "dosageTypeSegue"
            {
                vc.options = getOptionsFromMedication()
                vc.button = 2
                vc.selection = button2Type
            }
            else if id == "newMedicationSegue"
            {
                vc.options = getOptionsFromDosageType()
                vc.button = 3
                vc.selection = button3Type
            }
        }
        else {
            // Going home
        }
    }
    
    // fucntion for getting the options to choose from for the different medication types
    func getOptionsFromMedication() -> [String] {
        
        if button1 == medications[0]
        {
            return MorphineSulfate().dosageTypes
        }
        else if button1 == medications[1]
        {
            return Codeine().dosageTypes
        }
        else if button1 == medications[2]
        {
            return Hydrocodone().dosageTypes
        }
        else if button1 == medications[3]
        {
            return Hydromorphone().dosageTypes
        }
        else if button1 == medications[4]
        {
            return Oxycodone().dosageTypes
        }
        else
        {
            return Oxymorphone().dosageTypes
        }
    }
    
    func getOptionsFromDosageType() -> [String] {
        
        if button2 == "IV/SC"
        {
            return medicationsIV_SC
        }
        else if button2 == "PO"
        {
            return medicationsPO
        }
        else
        {
            return medicationsPR
        }
    }
    
    func setDosageLabel () {
        
        //check to make sure there is a valid value in the dossage field
        if initialDosage.text?.isEmpty == true
        {
            dosageLabel = "Please Enter Valid Dosage"
        }
        let dosageValue : Double = NSString(string: initialDosage.text!).doubleValue
        if dosageValue != 0.0
        {
            dosageLabel = getNewDosage(dosageValue)
        }
        else
        {
            dosageLabel = "Please EnterValid Dosage"
        }
        dosage.text = dosageLabel
        dosage.hidden = false
        
//        try {
//            let dosageValue : Double = NSString(string: initialDosage.text!).doubleValue
//        }
//        catch (){
//            
//        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        if textField.text != "" && !(textField.text?.containsString("mg"))! {
            textField.text = textField.text?.stringByAppendingString(" mg")
        }
    }
    
    func dismissKeyboard() {
        initialDosage.resignFirstResponder()
    }
    
    func getNewDosage(dosageValue: Double) -> String {
        
        let initialMedicationNormalDosage : Double = getMedicationNormalDosage(button2)
        let newMedicationNormalDosage : Double = getMedicationNormalDosage(button3)
        
        let finalDosage = (dosageValue / initialMedicationNormalDosage) * newMedicationNormalDosage
        let roundDosage = Double(round(1000 * finalDosage) / 1000)
        
        return "\(roundDosage) mg"
    }
    
    func getMedicationNormalDosage(button : String) -> Double {
        
        let med = button
        
        // if statements determine get the correcet value based of of the selected dosage type
        if button1 == medications[0]
        {
            if med == MorphineSulfate().dosageTypes[0]
            {
                return MorphineSulfate().iv_sc
            }
            else if med == MorphineSulfate().dosageTypes[1]
            {
                return MorphineSulfate().po
            }
            else
            {
                return MorphineSulfate().pr
            }
        }
        else if button1 == medications[1]
        {
            if med == Codeine().dosageTypes[0]
            {
                return Codeine().iv_sc
            }
            else if med == Codeine().dosageTypes[1]
            {
                return Codeine().po
            }
            else
            {
                return Codeine().pr
            }
        }
        else if button1 == medications[2]
        {
            return Hydrocodone().po
        }
        else if button1 == medications[3]
        {
            if med == Hydromorphone().dosageTypes[0]
            {
                return Hydromorphone().iv_sc
            }
            else if med == Hydromorphone().dosageTypes[1]
            {
                return Hydromorphone().po
            }
            else
            {
                return Hydromorphone().pr
            }
        }
        else if button1 == medications[4]
        {
            return Oxycodone().po
        }
        else
        {
            if med == Oxymorphone().dosageTypes[0]
            {
                return Oxymorphone().iv_sc
            }
            else
            {
                return Oxymorphone().po
            }
        }
    }
}
