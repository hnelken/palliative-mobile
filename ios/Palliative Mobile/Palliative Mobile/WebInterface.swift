//
//  WebInterface.swift
//  Palliative Mobile
//
//  Created by Harry Nelken on 2/21/16.
//  Copyright © 2016 CWRU-SP16. All rights reserved.

import UIKit
import Alamofire

class WebInterface: NSObject {
    
    // Optional response handlers
    var callBack: (() -> Void)?
    var errorHandler: (() -> Void)?
    
    // Pushes all page hit rows with user credentials for aggregation on master server
    func pushPageUsage() {

        let urlString = "\(kServerURL)\(kPushPageUsageRoute)"
        
        let pageHits = db.getPageHits()
        if pageHits.count > 0 {
            let parameters: [String : AnyObject] = [
                kCredentialsKey : db.getCredentials(),
                kPageHitsKey : pageHits
            ]
            
            // Send HTTP POST request
            Alamofire.request(.POST, urlString, parameters: parameters, encoding: .JSON)
                .responseString(encoding: NSUTF8StringEncoding) { response in
                    
                    if (response.result.isSuccess) {
                        // Page hits successfully updated, clear DB count
                        db.clearPageHits()
                    }
            }
        }
    }
    
    // Requests updates since last version
    func updatePages() {
        let urlString = "\(kServerURL)\(kUpdatePagesRoute)"
        let dbNumber = db.getVersionNumber()
        var maxVersion = dbNumber
        
        print("Version: \(dbNumber)")
        
        // Post the latest version number to get updates since then
        Alamofire.request(.POST, urlString, parameters: [kVersionParamKey : dbNumber], encoding: .URLEncodedInURL).responseJSON { response in
        
            if let stmts = response.result.value as? [AnyObject] {
                
                if let callback = self.callBack {
                    
                    // Update UI on main queue
                    dispatch_async(dispatch_get_main_queue()) {
                        callback()
                    }
                }
                self.callBack = nil
                
                print("UPDATES:")
                for stmt in stmts {
                    let dict = stmt as! [String : AnyObject]
                    let id = Int(dict["id"] as! String)!
                    
                    // Keep track of the highest ID
                    if id > maxVersion {
                        maxVersion = id
                    }
                    
                    // Execute the update
                    print(dict["statement"])
                    //db.executeUpdate(dict["statement"] as! String)
                }
                
                // Update the DB version with the highest ID
                if maxVersion > dbNumber {
                    db.updateVersion(maxVersion)
                }
            }
        }
    }
    
}
