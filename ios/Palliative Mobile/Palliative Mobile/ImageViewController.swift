//
//  ImageViewController.swift
//  Palliative Mobile
//
//  Created by Harry Nelken on 4/13/16.
//  Copyright © 2016 CWRU-SP16. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    
    let imageNames = ["terminal.png", "frailty.png", "organ.png", "sudden.png"]
    
    private var viewShowing: Int = 0
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var imageView4: UIImageView!
    
    @IBAction func backPressed(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = "Global Trajectories"
        
        // Set image views
        if let image1 = UIImage(named: imageNames[0]) {
            imageView.image = image1
        }
        if let image2 = UIImage(named: imageNames[1]) {
            imageView2.image = image2
        }
        if let image3 = UIImage(named: imageNames[2]) {
            imageView3.image = image3
        }
        if let image4 = UIImage(named: imageNames[3]) {
            imageView4.image = image4
        }
        
        viewShowing = 0
        imageView2.hidden = true
        imageView3.hidden = true
        imageView4.hidden = true
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: "rightSwipeHandler:")
        rightSwipe.direction = .Right
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: "leftSwipeHandler:")
        rightSwipe.direction = .Left
        self.view.addGestureRecognizer(rightSwipe)
        self.view.addGestureRecognizer(leftSwipe)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func rightSwipeHandler(recognizer: UISwipeGestureRecognizer) {
        swipeView(true)
    }
    
    func leftSwipeHandler(recognizer: UISwipeGestureRecognizer) {
        swipeView(false)
    }
    
    private func swipeView(isRightSwipe: Bool) {
        if !isRightSwipe {
            if viewShowing != imageNames.count {
                viewShowing += 1
            }
            
            switch (viewShowing) {
            case 0:
                flipView(imageView, toView: imageView2, dir: .TransitionFlipFromRight)
            case 1:
                flipView(imageView2, toView: imageView3, dir: .TransitionFlipFromRight)
            case 2:
                flipView(imageView3, toView: imageView4, dir: .TransitionFlipFromRight)
            default:
                print("can't swipe right anymore")
            }
            
            if viewShowing != 0 {
                viewShowing -= 1
            }
        }
        else {
            switch (viewShowing) {
            case 1:
                flipView(imageView2, toView: imageView, dir: .TransitionFlipFromLeft)
            case 2:
                flipView(imageView3, toView: imageView2, dir: .TransitionFlipFromLeft)
            case 3:
                flipView(imageView4, toView: imageView3, dir: .TransitionFlipFromLeft)
            default:
                print("can't swipe left anymore")
            }
            if viewShowing != imageNames.count {
                viewShowing += 1
            }
        }
    }

    private func flipView(fromView: UIView, toView: UIView, dir: UIViewAnimationOptions) {
        UIView.transitionFromView(fromView, toView: toView, duration: 0.75, options: [dir, .ShowHideTransitionViews], completion: nil)
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
