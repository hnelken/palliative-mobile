//
//  BookmarksViewController.swift
//  Palliative Mobile
//
//  Created by Harry Nelken on 2/21/16.
//  Copyright © 2016 CWRU-SP16. All rights reserved.
//

import UIKit

class BookmarksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var bookmarkTableView: UITableView!
    var nextPageID: Int!
    var bookmarks: [[AnyObject]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    
    }
    
    override func viewWillAppear(animated: Bool) {
        bookmarks = db.getBookmarks()
        bookmarkTableView.reloadData()
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
        return bookmarks.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(kBookmarkCellID, forIndexPath: indexPath)
        
        cell.textLabel?.text = bookmarks[indexPath.row][kLinkNameIndex] as? String
        cell.accessoryType = .DisclosureIndicator
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        // Save designated bookmark page id
        nextPageID = bookmarks[indexPath.row][kLinkIDIndex] as! Int
        
        // Transition to article view
        performSegueWithIdentifier(kShowBookmarkSegueID, sender: self)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // If going to the article view, pass along the page ID
        if let vc = segue.destinationViewController as? ArticleDisplayViewController {
            vc.pageID = nextPageID
        }
        
    }

}
