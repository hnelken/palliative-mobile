//
//  ImageViewController.swift
//  Palliative Mobile
//
//  Created by Harry Nelken on 4/13/16.
//  Copyright © 2016 CWRU-SP16. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {

    var titleText: String?
    var imageName: String?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBAction func backPressed(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let title = titleText {
            titleLabel.text = title
        }
        
        if let name = imageName {
            if let image = UIImage(named: name) {
                imageView.image = image
            }
        }
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
