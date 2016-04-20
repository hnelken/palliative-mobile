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
    
    @IBAction func skipSurveyPressed(sender: AnyObject) {
        db.optOut()
        db.releaseFirstTime()
        print("Skipped - first: \(db.getFirstTimeStatus()) - optOut: \(db.getOptOutStatus())")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
