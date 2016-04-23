//
//  AKPSViewController.swift
//  Palliative Mobile
//
//  Created by Andrew Marmorstein on 4/10/16.
//  Copyright © 2016 CWRU-SP16. All rights reserved.
//

import UIKit

class AKPSViewController: UIViewController {

    private let parentID = 77
    private var bookmarked: Bool = false
    
    // the title for the calc
    @IBOutlet weak var calcTitle: UILabel!

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
        
        db.commitBookmarkChanges(bookmarked, pageID: kAustraliaPageID)
    }
    
    override func viewWillAppear(animated: Bool) {
        bookmarked = db.isPageBookmarked(kAustraliaPageID)
        
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
