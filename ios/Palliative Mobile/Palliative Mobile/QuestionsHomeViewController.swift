//
//  QuestionsHomeViewController.swift
//  Palliative Mobile
//
//  Created by Andrew Marmorstein on 2/23/16.
//  Copyright © 2016 CWRU-SP16. All rights reserved.
//

import UIKit

class QuestionsHomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var quizes: [String] = [
        "quiz 1",
        "quiz 2",
        "quiz 3"
    ]

    @IBOutlet weak var quizTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.quizTable.separatorStyle = .None
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backToHomeSegue(segue: UIStoryboardSegue) { }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quizes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(kHomeCellID, forIndexPath: indexPath)
        
        cell.textLabel?.text = quizes[indexPath.row]
        cell.accessoryType = .DisclosureIndicator
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
    }
}
