//
//  WebInterface.swift
//  Palliative Mobile
//
//  Created by Harry Nelken on 2/21/16.
//  Copyright © 2016 CWRU-SP16. All rights reserved.
//
//
//  WebInterface.swift
//  scuttle
//
//  Created by Harry Nelken on 2/13/16.
//  Copyright © 2016 HackCWRU. All rights reserved.
//

import UIKit
import Alamofire

class WebInterface: NSObject {
    
    func requestToken(deviceID: String) {
        
        let urlString = "\(kBaseURL)\(kTokenRequestRoute)\(deviceID)"
        //let defaultChannel = "general"
        
        Alamofire.request(.GET, urlString).responseJSON { response in
            print(response.result)   // result of response serialization
            
            if response.result.isSuccess {
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                }
            }
            else {
                print("Token acquisition failed")
            }
        }
        
        //        // Get JSON from server
        //        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        //        let session = NSURLSession(configuration: config, delegate: nil, delegateQueue: nil)
        //        let url = NSURL(string: urlString)
        //        let request  = NSMutableURLRequest(URL: url!)
        //        request.HTTPMethod = "GET"
        //
        //        // Make HTTP request
        //        session.dataTaskWithRequest(request, completionHandler: { data, response, error in
        //            if (data != nil) {
        //                // Parse result JSON
        //                let json = JSON(data: data!)
        //                let token = json["token"].stringValue
        //                self.identity = json["identity"].stringValue
        //
        //                // Set up Twilio IPM client and join the general channel
        //                self.client = TwilioIPMessagingClient.ipMessagingClientWithToken(token, delegate: self)
        //
        //                // Auto-join the general channel
        //                self.client?.channelsListWithCompletion { result, channels in
        //                    if (result == .Success) {
        //                        if let channel = channels.channelWithUniqueName(defaultChannel) {
        //                            // Join the general channel if it already exists
        //                            self.generalChannel = channel
        //                            self.generalChannel?.joinWithCompletion({ result in
        //                                print("Channel joined with result \(result)")
        //                            })
        //                        } else {
        //                            // Create the general channel (for public use) if it hasn't been created yet
        //                            channels.createChannelWithFriendlyName("General Chat Channel", type: .Public) {
        //                                (channelResult, channel) -> Void in
        //                                if result == .Success {
        //                                    self.generalChannel = channel
        //                                    self.generalChannel?.joinWithCompletion({ result in
        //                                        self.generalChannel?.setUniqueName(defaultChannel, completion: { result in
        //                                            print("channel unqiue name set")
        //                                        })
        //                                    })
        //                                }
        //                            }
        //                        }
        //                    }
        //                }
        //
        //                // Update UI on main thread
        //                dispatch_async(dispatch_get_main_queue()) {
        //                    self.navigationItem.prompt = "Logged in as \"\(self.identity)\""
        //                }
        //            } else {
        //                print("Error fetching token :\(error)")
        //            }
        //        }).resume()
    }
    
    func verifyUser(email: String, password: String) {
        let urlString = "\(kServerURL)\(kVerifyUserRoute)"
        
        let parameters = [
            "email": email,
            "password": password
        ]
        
        Alamofire.request(.POST, urlString, parameters: parameters, encoding: .JSON)
            .response { response in
                print(response)
        }
    }
    
    func getEvents(userID: Int32) {
        
        let urlString = "\(kServerURL)\(kGetEventsRoute)\(userID)"
        
        Alamofire.request(.GET, urlString).responseJSON { response in
            print(response.result)   // result of response serialization
            
            if response.result.isSuccess {
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                }
            }
            else {
                print("Token acquisition failed")
            }
        }
    }
    
    func doStuff() {
        Alamofire.request(.POST, "http://URLGOESHERE")
        
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
        }
        
        
    }
    
}
