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
        "Care for the Frail",
        "Death & Resuscitation",
        "Managing Common Symptoms",
        "Bookmarks"
    ]
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var rapidButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        db.getAllData()
        
        rapidButton.layer.cornerRadius = 20
        rapidButton.clipsToBounds = true
        
        self.tableView.separatorStyle = .None
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        navigationController?.navigationBarHidden = true
    }

    @IBAction func backToHomeSegue(segue: UIStoryboardSegue) { }

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
        case 3: segueID = kBookmarkSegueID
        default: segueID = kArticleSegueID
        }
        
        if let id = segueID {
           performSegueWithIdentifier(id, sender: self)
        }
    }
}

