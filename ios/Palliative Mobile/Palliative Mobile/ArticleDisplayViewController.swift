//
//  ArticleDisplayViewController.swift
//  Palliative Mobile
//
//  Created by Harry Nelken on 2/26/16.
//  Copyright © 2016 CWRU-SP16. All rights reserved.
//

import UIKit

class ArticleDisplayViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var bookmarkButton: UIButton!
    @IBOutlet weak var detailButton: UIButton!
    @IBOutlet weak var navUpButton: UIButton!
    @IBOutlet weak var linksButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var textButton: UIButton!
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textScrollView: UIScrollView!
    @IBOutlet weak var detailScrollView: UIScrollView!
    
    var lastPage: ArticleDisplayViewController?
    var thisPage: [String : AnyObject]?
    var links: [[AnyObject]] = []
    
    var pageID: Int!
    private var lastPageID: Int!
    private var parentID: Int!
    
    private enum ViewType {
        case Detail
        case Text
        case Links
    }
    
    private var viewType: ViewType!
    private var currentView: UIView?
    
    private var titleText: String?
    private var subtitleText: String?
    private var descriptionText: String?
    
    private var bookmarked: Bool = false
    private var initMarked: Bool = false
    private var backPops: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        formatView()
    }
    
    override func viewDidAppear(animated: Bool) {
        //let page = db.getPage(pageID)
        let isBookmarked: Bool = (thisPage![kPageBookmarkedKey] as! NSNumber).boolValue
        
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
        // Show detail view if not already showing
        if viewType != .Detail && !descriptionText!.isEmpty {
            UIView.transitionFromView(currentView!,
                                      toView: detailScrollView,
                                      duration: 1,
                                      options: [.TransitionFlipFromTop, .ShowHideTransitionViews],
                                      completion: nil)
            
            // Set current view
            currentView = detailScrollView
            viewType = .Detail
        }
    }
    
    @IBAction func linksPressed(sender: AnyObject) {
        // Show links view if not already showing
        if viewType != .Links && links.count > 0 {
            UIView.transitionFromView(currentView!,
                                      toView: tableView,
                                      duration: 1,
                                      options: [.TransitionFlipFromTop, .ShowHideTransitionViews],
                                      completion: nil)
            
            // Set current view
            currentView = tableView
            viewType = .Links
        }
    }
    
    @IBAction func textPressed(sender: AnyObject) {
        // Show links view if not already showing
        if viewType != .Text {
            UIView.transitionFromView(currentView!,
                                      toView: textScrollView,
                                      duration: 1,
                                      options: [.TransitionFlipFromTop, .ShowHideTransitionViews],
                                      completion: nil)
            
            // Set current view
            currentView = textScrollView
            viewType = .Text
        }
    }
    
    @IBAction func navUpPressed(sender: AnyObject) {
        if (parentID > 1) {
            transitionToPage(parentID)
        }
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
        thisPage = db.getPage(pageID)
        let contentArray: [String]? = thisPage![kPageContentKey] as? [String]
        links = thisPage![kPageLinksKey] as! [[AnyObject]]
        parentID = (thisPage![kPageParentIDKey] as! NSNumber).integerValue
        bookmarked = (thisPage![kPageBookmarkedKey] as! NSNumber).boolValue
        initMarked = bookmarked
        
        // Pass on the next article's info for display
        if let content = contentArray {
            titleText = content[kContentTitleIndex]
            subtitleText = content[kContentSubtitleIndex]
            descriptionText = content[kContentTextIndex]
            
            // Update text labels with article text
            titleLabel.text = titleText
            detailLabel.text = descriptionText
        }
        
        // Check bookmarked status
        if bookmarked {
            bookmarkButton.setBackgroundImage(UIImage(named: "bookmark-red"), forState: .Normal)
        }
        else {
            bookmarkButton.setBackgroundImage(UIImage(named: "bookmark-white"), forState: .Normal)
        }
        
        // Set first view
        if links.count == 0 {
            viewType = .Detail
            currentView = detailScrollView
            textScrollView.hidden = true
            tableView.hidden = true
        }
        else {
            viewType = .Links
            currentView = tableView
            textScrollView.hidden = true
            detailScrollView.hidden = true
        }
        
        // Resize labels and scroll view
        titleLabel.sizeToFit()
        tableView.reloadData()
    }
    
    private func transitionToPage(dstID: Int) {
        
        let vc = storyboard?.instantiateViewControllerWithIdentifier("articleViewController") as! ArticleDisplayViewController
        
        vc.lastPage = self
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
