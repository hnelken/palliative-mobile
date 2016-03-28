//
//  ViewController.swift
//  Palliative Mobile
//
//  Created by Harry Nelken on 2/18/16.
//  Copyright © 2016 CWRU-SP16. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var links: [String] = [
        "Rapid PC Assessment",
        "Care for the Frail",
        "Death & Resuscitation",
        "Managing Common Symptoms",
        "Bookmarks"
    ]
    
    var searchResults: [[AnyObject]] = []
    var destination: Int = -1
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.separatorStyle = .None
    }
    
    override func viewDidAppear(animated: Bool) {
        let del = UIApplication.sharedApplication().delegate as! AppDelegate
        if del.firstTime {
            del.firstTime = false
            //Create the AlertController
            let actionSheetController: UIAlertController = UIAlertController(title: "Palliative Mobile Demographic Survey", message: "It appears this is your first time here, would you please take the time to complete a short, anonymous survey? We won't ask for any identifying information!", preferredStyle: .ActionSheet)
            
            //Create and add the Cancel action
            let cancelAction: UIAlertAction = UIAlertAction(title: "No, thanks", style: .Cancel) { action -> Void in
                //Just dismiss the action sheet
            }
            actionSheetController.addAction(cancelAction)
            //Create and add first option action
            let takePictureAction: UIAlertAction = UIAlertAction(title: "Sure!", style: .Default) { action -> Void in
                //Code for launching the camera goes here
                self.performSegueWithIdentifier(kFirstTimeSegueID, sender: self)
            }
            actionSheetController.addAction(takePictureAction)
            //Present the AlertController
            self.presentViewController(actionSheetController, animated: true, completion: nil)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        navigationController?.navigationBarHidden = true
        self.tableView.separatorStyle = .None
    }

    @IBAction func backToHomeSegue(segue: UIStoryboardSegue) { }

    @IBAction func searchPressed(sender: AnyObject) {
        
        if let query = searchText.text {
            if query != "" {
                searchResults = db.performSearch(query)
                performSegueWithIdentifier(kShowSearchSegueID, sender: self)
            }
        }
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
        
        return tableView.frame.size.height / CGFloat(links.count)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(kHomeCellID, forIndexPath: indexPath)
        
        cell.textLabel?.text = links[indexPath.row]
        cell.accessoryType = .DisclosureIndicator
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        var segueID: String?
        
        switch indexPath.row {
        case 0:
            destination = 2;
            segueID = kArticleSegueID
        case 1, 2, 3:
            destination = 51;
            segueID = kArticleSegueID
        case 4: segueID = kBookmarkSegueID
        default:
            destination = 51;
            segueID = kArticleSegueID
        }
        
        if let id = segueID {
           performSegueWithIdentifier(id, sender: self)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let vc = segue.destinationViewController as? ArticleDisplayViewController {
            // Pass on page ID
            vc.pageID = destination
        }
        else if let vc = segue.destinationViewController as? SearchViewController {
            vc.results = searchResults
        }
    }
}

