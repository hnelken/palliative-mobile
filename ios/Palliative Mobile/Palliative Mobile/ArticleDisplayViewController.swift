//
//  ArticleDisplayViewController.swift
//  Palliative Mobile
//
//  Created by Harry Nelken on 2/26/16.
//  Copyright © 2016 CWRU-SP16. All rights reserved.
//

import UIKit

class ArticleDisplayViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bookmarkButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var detailButton: UIButton!
    @IBOutlet weak var navUpButton: UIButton!
    
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var detailScrollView: UIScrollView!
    var nextPage: [String : AnyObject]?
    var links: [[AnyObject]] = []
    
    var detailShowing: Bool = false
    var pageID: Int!
    private var titleText: String?
    private var subtitleText: String?
    private var descriptionText: String?
    private var bookmarked: Bool = false
    private var initMarked: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        formatView()
    }
    
    override func viewDidAppear(animated: Bool) {
        let page = db.getPage(pageID)
        let isBookmarked: Bool = (page[kPageBookmarkedKey] as! NSNumber).boolValue
        
        bookmarked = isBookmarked
        initMarked = isBookmarked
    }
    
    override func viewDidLayoutSubviews() {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func bookmarkPressed(sender: AnyObject) {
        
        if !bookmarked {
            bookmarkButton.setBackgroundImage(UIImage(named: "bookmark-red"), forState: .Normal)
            bookmarked = true
        }
        else {
            bookmarkButton.setBackgroundImage(UIImage(named: "bookmark-white"), forState: .Normal)
            bookmarked = false
        }
    }
    
    @IBAction func detailPressed(sender: AnyObject) {
        
        if !detailShowing {
            UIView.transitionFromView(tableView,
                toView: detailScrollView,
                duration: 1,
                options: .TransitionFlipFromRight,
                completion: nil)
        }
        else {
            UIView.transitionFromView(detailScrollView,
                toView: tableView,
                duration: 1,
                options: .TransitionFlipFromLeft,
                completion: nil)
        }
        
        detailShowing = !detailShowing
    }
    
    @IBAction func navUpPressed(sender: AnyObject) {
    }
    
    @IBAction func homePressed(sender: AnyObject) {
        // Commit bookmark changes
        if bookmarked != initMarked {
            db.commitBookmarkChanges(bookmarked, pageID: pageID)
        }
        
        performSegueWithIdentifier(kHomeSegueID, sender: self)
    }
    
    
    @IBAction func backPressed(sender: AnyObject) {
        // Commit bookmark changes
        if bookmarked != initMarked {
            db.commitBookmarkChanges(bookmarked, pageID: pageID)
        }
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    //
    // MARK: Private
    //
    private func formatView() {
        // Get page
        let page = db.getPage(pageID)
        let content: [String] = page[kPageContentKey] as! [String]
        links = page[kPageLinksKey] as! [[AnyObject]]
        bookmarked = (page[kPageBookmarkedKey] as! NSNumber).boolValue
        initMarked = bookmarked
        
        // Pass on the next article's info for display
        titleText = content[kContentTitleIndex]
        subtitleText = content[kContentSubtitleIndex]
        descriptionText = content[kContentTextIndex]
        
        // Update text labels with article text
        titleLabel.text = titleText
        detailLabel.text = descriptionText
        
        // Check bookmarked status
        if bookmarked {
            bookmarkButton.setBackgroundImage(UIImage(named: "bookmark-red"), forState: .Normal)
        }
        else {
            bookmarkButton.setBackgroundImage(UIImage(named: "bookmark-white"), forState: .Normal)
        }
        
        // Resize labels and scroll view
        titleLabel.sizeToFit()
    }
    
    private func transitionToPage(dstID: Int) {
        
        let vc = storyboard?.instantiateViewControllerWithIdentifier("articleViewController") as! ArticleDisplayViewController
        
        vc.pageID = dstID
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    //
    // MARK: Table View Delegate/Data Source
    //
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    // Cell count
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return links.count
    }
    
    // Cell height
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return links.count > 4
            ? tableView.frame.height / CGFloat(links.count)
            : tableView.frame.height / 4
    }
    
    // Formats the cells in the table
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(kArticleLinkCellID, forIndexPath: indexPath) as! ArticleLinkCell
        
        // Get link titles
        let link = links[indexPath.row]
        if let linkName = link[kLinkNameIndex] as? String {
            cell.linkLabel?.text = linkName
        }
        else {  // Link text is missing in db
            cell.linkLabel?.text = "(title missing)"
        }
        cell.linkLabel.sizeToFit()
        cell.accessoryType = .DisclosureIndicator
        
        return cell
    }
    
    // Reformats article upon select
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        // Commit bookmark changes
        if bookmarked != initMarked {
            db.commitBookmarkChanges(bookmarked, pageID: pageID)
        }
        
        let link = links[indexPath.row]
        let dstID = link[kLinkIDIndex] as! NSNumber
        transitionToPage(dstID.integerValue)
        
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
