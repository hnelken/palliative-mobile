//
//  SearchViewController.swift
//  Palliative Mobile
//
//  Created by Harry Nelken on 3/17/16.
//  Copyright © 2016 CWRU-SP16. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    var nextPageID: Int!
    var results: [[AnyObject]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
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
        return results.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(kSearchCellID, forIndexPath: indexPath)
        
        cell.textLabel?.text = results[indexPath.row][kLinkNameIndex] as? String
        cell.accessoryType = .DisclosureIndicator
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        // Save designated bookmark page id
        nextPageID = results[indexPath.row][kLinkIDIndex] as! Int
        
        // Check if the page is special or a normal article
        if specialPages.contains(nextPageID) {
            let segueID = getSpecialPageSegue(nextPageID)
            if let id = segueID {
                performSegueWithIdentifier(id, sender: self)
            }
            else {
                print("Unidentified special page")
            }
        }
        else {
            // Transition to article view
            performSegueWithIdentifier(kShowSearchResultSegueID, sender: self)
        }
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
