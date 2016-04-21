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
        
        imageView2.hidden = true
        imageView3.hidden = true
        imageView4.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
