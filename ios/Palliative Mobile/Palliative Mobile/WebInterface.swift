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
    var responseParser: ((response: AnyObject) -> Void)?
    var errorHandler: (() -> Void)?
    
    // Pushes all page hit rows with user credentials for aggregation on master server
    func pushPageUsage() {

        let urlString = "\(kServerURL)\(kPushPageUsageRoute)"
        let parameters: [String : AnyObject] = [
            "credentials" : db.getCredentials(),
            "page_hits" : db.getPageHits()
        ]
        
        print(parameters)
        
        Alamofire.request(.POST, urlString, parameters: parameters, encoding: .JSON)
            .response { response in
                
                // Page hits successfully updated, clear DB count
                db.clearPageHits()
        }
    }
    
    func updatePages() {
        let urlString = "\(kServerURL)\(kUpdatePagesRoute)"
        let dbNumber = 1
        
        Alamofire.request(.POST, urlString, parameters: ["v" : dbNumber], encoding: .URLEncodedInURL).responseJSON { response in
            
            print(response.request?.URLString)
            
        }
    }
    
}
