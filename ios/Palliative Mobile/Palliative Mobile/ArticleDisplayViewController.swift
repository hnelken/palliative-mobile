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
    
    var nextPage: [String : AnyObject]?
    var links: [[AnyObject]] = [
        ["Random Link 1", 1],
        ["Random Link 2", 2]
    ]
    
    var titleText: String?
    var subtitleText: String?
    var descriptionText: String?

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
        
        // Update table
        
        
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
    
    //
    // MARK: Table View Delegate/Data Source
    //
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return links.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return tableView.frame.height / 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(kArticleLinkCellID, forIndexPath: indexPath)
        
        // Get link titles
        let link = links[indexPath.row]
        cell.textLabel?.text = link[kLinkNameIndex] as? String
        cell.accessoryType = .DisclosureIndicator
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        // Look up page in DB
        let link = links[indexPath.row]
        let dstID = link[kLinkIDIndex] as! NSNumber
        
        let page = db.getPage(dstID.intValue)
        
        let nextContent: [String] = page[kPageContentKey] as! [String]
        let nextLinks: [[AnyObject]] = page[kPageLinksKey] as! [[AnyObject]]
        
        self.titleText = nextContent[kContentTitleIndex]
        self.subtitleText = nextContent[kContentSubtitleIndex]
        self.descriptionText = nextContent[kContentTextIndex]
        self.links = nextLinks
        
        tableView.reloadData()
        self.viewDidLoad()
        
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
