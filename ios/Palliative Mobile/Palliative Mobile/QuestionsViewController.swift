//
//  QuestionsViewController.swift
//  Palliative Mobile
//
//  Created by Andrew Marmorstein on 2/23/16.
//  Copyright © 2016 CWRU-SP16. All rights reserved.
//

import UIKit

class QuestionsViewController: UIViewController {
    
    var questionToAsk = "How much wood could a wood chuck chuck if a wood chuck could chuck wood"
    
    var answers = [
        "A little",
        "A lot",
        "Enough",
        "Too Much"
    ]
    
    var answerShown = 0
    
    var correctAnswer = "Enough"

    @IBOutlet weak var question: UITextView!
    @IBOutlet weak var answerChoice: UITextView!
    
    @IBOutlet weak var submit: UIButton!
    
    @IBOutlet var rightSwipe: UISwipeGestureRecognizer!
    @IBOutlet var leftSwipe: UISwipeGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        question.text = questionToAsk
        answerChoice.text = answers[answerShown]
    }
    
    @IBAction func swippedRight(sender: AnyObject) {
        if answerShown < (answers.count-1) {
            answerShown++
            answerChoice.text = answers[answerShown]
        }
    }
    
    @IBAction func swippedLeft(sender: AnyObject) {
        if answerShown > 0 {
            answerShown--
            answerChoice.text = answers[answerShown]
        }
    }

    @IBAction func answerSubmitted(sender: AnyObject) {
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let vc = segue.destinationViewController as! ResultPageViewController
        
        vc.hintShown = "you are wrong"
        vc.correct = answers[answerShown] == correctAnswer
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
