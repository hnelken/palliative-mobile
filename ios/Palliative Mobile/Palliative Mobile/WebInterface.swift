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
    
    // EXAMPLE API CALL
    func doStuff() {
        let parameters = [
            "foo": [1,2,3],
            "bar": [
                "baz": "qux"
            ]
        ]
        Alamofire.request(.POST, "https://httpbin.org/post", parameters: parameters, encoding: .JSON)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .response { response in
                print(response)
                
                
                // USE THIS TO UPDATE UI DURING ASYNC RESPONSE HANDLERS
                dispatch_async(dispatch_get_main_queue()) {
                    print("UPDATE ON UI THREAD")
                }
        }
    }
    
    // Common user verification API call
    func verifyUser(email: String, password: String,
        parser: (response: AnyObject)-> Void, errorHandler: (() -> Void)?) {
        
            self.responseParser = parser
            self.errorHandler = errorHandler
        
            let urlString = "\(kServerURL)\(kVerifyUserRoute)"
        
            let parameters = [
                "email": email,
                "password": password
            ]
        
            makeAPICall(urlString, parameters: parameters)
    }
    
    // Abstraction for making an HTTP POST request using JSON encoded parameters
    private func makeAPICall(urlString: String, parameters: [String : AnyObject]) {
        
        Alamofire.request(.POST, urlString, parameters: parameters, encoding: .JSON)
            .responseJSON { response in
                
                print(response)
                
                // Hand response to parser if valid
                if let JSON = response.result.value {
                    if let parser = self.responseParser {
                        parser(response: JSON)
                    }
                }
                else {
                    // Handle error
                    if let errorHandler = self.errorHandler {
                        errorHandler()
                    }
                }
        }
        
    }
    
    
}
