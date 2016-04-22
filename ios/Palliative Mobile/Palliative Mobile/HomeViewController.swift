//
//  ViewController.swift
//  Palliative Mobile
//
//  Created by Harry Nelken on 2/18/16.
//  Copyright © 2016 CWRU-SP16. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    var links: [String] = [
        "Rapid PC Assessment",
        "Care for the Frail",
        "Death & Resuscitation",
        "Managing Common Symptoms",
        "Interactive Learning",
        "Bookmarks"
    ]
    
    var searchResults: [[AnyObject]] = []
    var destination: Int = -1
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchText.delegate = self
        let tap = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    override func viewDidAppear(animated: Bool) {
        if db.getFirstTimeStatus() {
            // Segue to tutorial
            self.performSegueWithIdentifier(kFirstTimeSegueID, sender: self)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        navigationController?.navigationBarHidden = true
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
        if indexPath.row == links.count - 2 || indexPath.row == links.count - 1 {
            cell.backgroundColor = UIColor.groupTableViewBackgroundColor()
            cell.contentView.backgroundColor = UIColor.groupTableViewBackgroundColor()
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        var segueID: String?
        
        switch indexPath.row {
        case 0:
            destination = kRapidPCPageID;
            segueID = kArticleSegueID
        case 1:
            destination = kCareForFrailPageID;
            segueID = kArticleSegueID
        case 2:
            destination = kDeathResusPageID;
            segueID = kArticleSegueID
        case 3:
            destination = kCommonSymptomsPageID;
            segueID = kArticleSegueID
        case 4:
            segueID = kQuizSegueID
        case 5:
            segueID = kBookmarkSegueID
        default:
            segueID = kQuizSegueID
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
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if let query = textField.text {
            if query != "" {
                textField.resignFirstResponder()
                searchResults = db.performSearch(query)
                performSegueWithIdentifier(kShowSearchSegueID, sender: self)
            }
        }
        return true
    }
    
    func dismissKeyboard() {
        searchText.resignFirstResponder()
    }
}

