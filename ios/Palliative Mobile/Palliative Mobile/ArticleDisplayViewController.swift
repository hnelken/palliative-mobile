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
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
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
    private var normalText: String?
    private var detailText: String?
    
    private var bookmarked: Bool = false
    private var initMarked: Bool = false
    private var backPops: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
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
        if viewType != .Detail && !detailText!.isEmpty {
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
        if let content = thisPage![kPageContentKey] {
            let contentArray = content as! [String]
            links = thisPage![kPageLinksKey] as! [[AnyObject]]
            parentID = (thisPage![kPageParentIDKey] as! NSNumber).integerValue
            bookmarked = (thisPage![kPageBookmarkedKey] as! NSNumber).boolValue
            initMarked = bookmarked
            
            // Pass on the next article's info for display
            //if let content = contentArray {
                titleText = contentArray[kContentTitleIndex]
                normalText = contentArray[kContentTextIndex]
                detailText = contentArray[kContentDetailIndex]
                
                // Update text labels with article text
                titleLabel.text = titleText
                if normalText != "" {
                    textLabel.text = normalText
                }
                else {
                    textLabel.text = "No text to display.\nSee detail tab if available."
                }
                detailLabel.text = detailText
            //}
            
            // Check bookmarked status
            if bookmarked {
                bookmarkButton.setBackgroundImage(UIImage(named: "bookmark-red"), forState: .Normal)
            }
            else {
                bookmarkButton.setBackgroundImage(UIImage(named: "bookmark-white"), forState: .Normal)
            }
            
            // Set first view
            if links.count == 0 {
                segmentControl.setEnabled(false, forSegmentAtIndex: 0)
                segmentControl.selectedSegmentIndex = 1
                
                viewType = .Text
                currentView = textScrollView
                detailScrollView.hidden = true
                tableView.hidden = true
                
                if (detailText!.isEmpty) {
                    segmentControl.setEnabled(false, forSegmentAtIndex: 2)
                }
            }
            else {
                viewType = .Links
                currentView = tableView
                textScrollView.hidden = true
                detailScrollView.hidden = true
                
                if (normalText!.isEmpty) {
                    segmentControl.setEnabled(false, forSegmentAtIndex: 1)
                }
                if (detailText!.isEmpty) {
                    segmentControl.setEnabled(false, forSegmentAtIndex: 2)
                }
            }
        }
        
        //let contentArray: [String]? = thisPage![kPageContentKey] as? [String]
        
        
        // Resize labels and scroll view
        titleLabel.sizeToFit()
        tableView.reloadData()
    }
    
    @IBAction func sectionPressed(sender: AnyObject) {
        
        var nextType: ViewType?
        var nextView: UIView?
        
        switch (sender.selectedSegmentIndex) {
        case 0: nextType = .Links
        case 1: nextType = .Text
        case 2: nextType = .Detail
        default: break
        }
        
        if nextType == .Links && links.count > 0 {
            nextView = tableView
        }
        else if nextType == .Detail && !detailText!.isEmpty {
            nextView = detailScrollView
        }
        else if nextType == .Text {
            nextView = textScrollView
        }
        
        if let toView = nextView {
            UIView.transitionFromView(
                currentView!,
                toView: toView,
                duration: 0.75,
                options: [.TransitionFlipFromLeft, .ShowHideTransitionViews],
                completion: nil)
            
            currentView = toView
            viewType = nextType
        }
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
        
        return links.count <= 4
            ? tableView.frame.height / 4
            : (links.count < 7
                ? tableView.frame.height / CGFloat(links.count)
                : tableView.frame.height / 6)
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
        
        // Check if the destination is a special page
        if specialPages.contains(dstID.integerValue) {
            
            segueToSpecialPage(dstID.integerValue)
        }
        else {
            transitionToPage(dstID.integerValue)
        }
        
    }
    
    // Recognizes a special page ID and performs the corresponding segue
    private func segueToSpecialPage(dstID: Int) {
        let segue: String?
        
        switch (dstID) {
        case kSeattlePageID:
            segue = kSeattleSegueID
        case kNewYorkPageID:
            segue = kNewYorkSegueID
        case kKarnofskyPageID:
            segue = kKarnofskySegueID
        case kAustrailiaPageID:
            segue = kAustraliaSegueID
        case kPrognosticPageID:
            segue = kPrognosticSegueID
        case kPerformancePageID:
            segue = kPerformanceSegueID
        case kECOGPageID:
            segue = kECOGSegueID
        case kSAAGPageID:
            segue = kSAAGSegueID
        case kTrajectoryPageID:
            segue = kTrajectorySegueID
        default:
            segue = nil
            print("Unidentified special page ID")
        }
        
        if let id = segue {
            //performSegueWithIdentifier(id, sender: self)
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
