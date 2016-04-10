//
//  PageContentController.swift
//  Palliative Mobile
//
//  Created by Harry Nelken on 4/9/16.
//  Copyright © 2016 CWRU-SP16. All rights reserved.
//

import UIKit

class PageContentController: UIViewController {
    
    var pageIndex: Int!
    var imageName: String!
    var rootController: RootPageViewController!

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let image = imageName {
            imageView.image = UIImage(named: image)
        }
    }
    
    @IBAction func toSurveyPressed(sender: AnyObject) {
        rootController.segueToSurvey()
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
