//
//  NYHFViewController.swift
//  Palliative Mobile
//
//  Created by Andrew Marmorstein on 4/10/16.
//  Copyright © 2016 CWRU-SP16. All rights reserved.
//

import UIKit

class NYHFViewController: UIViewController {

    private let parentID = 18
    private var bookmarked: Bool = false
    @IBOutlet weak var info: UITextView!
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
        
        db.commitBookmarkChanges(bookmarked, pageID: kNewYorkPageID)
    }
    
    override func viewWillAppear(animated: Bool) {
        bookmarked = db.isPageBookmarked(kNewYorkPageID)
        
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

        // Do any additional setup after loading the view.
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
