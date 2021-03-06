//
//  AppDelegate.swift
//  Palliative Mobile
//
//  Created by Harry Nelken on 2/18/16.
//  Copyright © 2016 CWRU-SP16. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var optedOut: Bool = false
    
    // Installs the database if not already installed
    func createCopyOfDatabaseIfNeeded() {
        var success: Bool
        let fileManager = NSFileManager.defaultManager()
        
        // Check if the database is installed
        success = fileManager.fileExistsAtPath(dbPath)
        if (success) {
            print("Database already exists in app's document")
            optedOut = db.getOptOutStatus()
            
            // Not first launch, so upload
            // page usage and get updates
            if !optedOut && !db.getFirstTimeStatus() {
                web.pushPageUsage()
                web.updatePages()
            }
            return
        }
        
        do {
            // The writable database does not exist, so copy the default to the appropriate location.
            let defaultDBPath = NSBundle.mainBundle().resourcePath?.NS.stringByAppendingPathComponent(kDBName);
            try fileManager.copyItemAtPath(defaultDBPath!, toPath: dbPath)
            print("Successfully copied database from bundle to app's document")
            
            // Initialize the application and get updates
            db.updateVersion(kBaseDBVersion)
            db.setFirstTimeTrue()
            web.updatePages()
        }
        catch {
            // Something went wrong
            print("Failed to create writable database file")
        }
    }

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        createCopyOfDatabaseIfNeeded()
        
        // Change page control appearance
        let pageControl = UIPageControl.appearance()
        pageControl.pageIndicatorTintColor = UIColor.lightGrayColor()
        pageControl.currentPageIndicatorTintColor = UIColor.whiteColor()
        pageControl.backgroundColor = UIColor.groupTableViewBackgroundColor()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

