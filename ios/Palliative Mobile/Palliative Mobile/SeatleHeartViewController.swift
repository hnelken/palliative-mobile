//
//  SeatleHeartViewController.swift
//  Palliative Mobile
//
//  Created by Andrew Marmorstein on 3/24/16.
//  Copyright © 2016 CWRU-SP16. All rights reserved.
//

import UIKit

class SeatleHeartViewController: UIViewController {

    @IBOutlet weak var seatleHeartWeb: UIWebView!
    
    let url = "https://depts.washington.edu/shfm/iPhone/app.php"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let requestURL = NSURL(string:url)
        let request = NSURLRequest(URL: requestURL!)
        seatleHeartWeb.loadRequest(request)
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
