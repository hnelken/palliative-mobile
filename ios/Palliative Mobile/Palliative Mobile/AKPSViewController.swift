//
//  AKPSViewController.swift
//  Palliative Mobile
//
//  Created by Andrew Marmorstein on 4/10/16.
//  Copyright © 2016 CWRU-SP16. All rights reserved.
//

import UIKit

class AKPSViewController: UIViewController {

    
    @IBOutlet weak var calcTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        calcTitle.sizeToFit()
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
