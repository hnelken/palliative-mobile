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
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var bookmarkButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    var nextPage: [String : AnyObject]?
    var links: [[AnyObject]] = [
        ["Random Link 1", 1],
        ["Random Link 2", 2]
    ]
    
    var parentID: Int?
    var titleText: String?
    var subtitleText: String?
    var descriptionText: String?
    var bookmarked: Bool?
    var initMarked: Bool?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Update text labels with article text
        if let title = titleText {
            titleLabel.text = title
        }
        if let subtitle = subtitleText {
            subtitleLabel.text = subtitle
        }
        if let description = descriptionText {
            descriptionLabel.text = description
        }
        
        // Check bookmarked status
        if let marked = bookmarked {
            initMarked = marked
            if !marked {
                bookmarkButton.setBackgroundImage(UIImage(named: "bookmark-red"), forState: .Normal)
            }
            else {
                bookmarkButton.setBackgroundImage(UIImage(named: "bookmark-white"), forState: .Normal)
            }
        }
        else {
            bookmarkButton.setBackgroundImage(UIImage(named: "bookmark-white"), forState: .Normal)
            bookmarked = false
            initMarked = false
        }
        
        // Resize labels and scroll view
        titleLabel.sizeToFit()
        subtitleLabel.sizeToFit()
        descriptionLabel.sizeToFit()
        scrollView.sizeToFit()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func bookmarkPressed(sender: AnyObject) {
        
        if let marked = bookmarked {
            if !marked {
                bookmarkButton.setBackgroundImage(UIImage(named: "bookmark-red"), forState: .Normal)
                bookmarked = true
            }
            else {
                bookmarkButton.setBackgroundImage(UIImage(named: "bookmark-white"), forState: .Normal)
                bookmarked = false
            }
        }
        
    }
    
    @IBAction func backPressed(sender: AnyObject) {
        // Commit bookmark changes
        
        self.navigationController?.popViewControllerAnimated(true)
//        // Get predecessor page id
//        if let parent = parentID {
//            transitionToPage(parent)
//        }
//        else {
//            performSegueWithIdentifier("backToHomeSegue", sender: self)
//        }
        
    }
    
    //
    // MARK: Private api
    //
    private func transitionToPage(dstID: Int) {//, tableView: UITableView) {
        
        
        let vc = storyboard?.instantiateViewControllerWithIdentifier("articleViewController") as! ArticleDisplayViewController
        let page = db.getPage(dstID)
        
        let nextContent: [String] = page[kPageContentKey] as! [String]
        let nextLinks: [[AnyObject]] = page[kPageLinksKey] as! [[AnyObject]]
        
        vc.titleText = nextContent[kContentTitleIndex]
        vc.subtitleText = nextContent[kContentSubtitleIndex]
        vc.descriptionText = nextContent[kContentTextIndex]
        vc.links = nextLinks
//
//        tableView.reloadData()
        //        self.viewDidLoad()
        
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
        
        return tableView.frame.height / 2
    }
    
    // Formats the cells in the table
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(kArticleLinkCellID, forIndexPath: indexPath)
        
        // Get link titles
        let link = links[indexPath.row]
        if let linkName = link[kLinkNameIndex] as? String {
            cell.textLabel?.text = linkName
        }
        else {  // Link text is missing in db
            cell.textLabel?.text = "(title missing)"
        }
        cell.accessoryType = .DisclosureIndicator
        
        return cell
    }
    
    // Reformats article upon select
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let link = links[indexPath.row]
        let dstID = link[kLinkIDIndex] as! NSNumber
        transitionToPage(dstID.integerValue)//, tableView: tableView)
        
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
