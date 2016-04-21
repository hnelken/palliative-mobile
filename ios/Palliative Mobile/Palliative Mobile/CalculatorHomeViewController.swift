//
//  CalculatorHomeViewController.swift
//  Palliative Mobile
//
//  Created by Andrew Marmorstein on 3/17/16.
//  Copyright © 2016 CWRU-SP16. All rights reserved.
//

import UIKit

class CalculatorHomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var calculators: [String] = [
        "Paliative Performance Scale"
    ]
    
    @IBOutlet weak var calculatorTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        navigationController?.navigationBarHidden = true
    }
    
    @IBAction func backToCalculatorHomeSegue(segue: UIStoryboardSegue) { }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return calculators.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return tableView.frame.size.height / CGFloat(calculators.count)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier(, forIndexPath: indexPath)
        let cell = tableView.dequeueReusableCellWithIdentifier(<#T##identifier: String##String#>, forIndexPath: <#T##NSIndexPath#>)
        
        cell.textLabel?.text = calculators[indexPath.row]
        cell.accessoryType = .DisclosureIndicator
        
        return cell
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
