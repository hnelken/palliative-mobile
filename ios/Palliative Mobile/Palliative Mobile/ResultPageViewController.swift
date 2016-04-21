//
//  ResultPageViewController.swift
//  Palliative Mobile
//
//  Created by Andrew Marmorstein on 4/19/16.
//  Copyright © 2016 CWRU-SP16. All rights reserved.
//

import UIKit

class ResultPageViewController: UIViewController {

    @IBOutlet weak var result: UILabel!
    
    @IBOutlet weak var retryButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var hint: UITextView!
    
    var correct = false
    
    var hintShown = "you were not right"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if correct {
            result.text = "Correct"
            result.textColor = UIColor.greenColor()
            hint.hidden = true
            retryButton.hidden = true
        }
        else {
            result.text = "Incorrect"
            result.textColor = UIColor.redColor()
            hint.text = hintShown
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
