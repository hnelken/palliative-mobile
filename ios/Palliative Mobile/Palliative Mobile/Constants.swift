//
//  Constants.swift
//  Palliative Mobile
//
//  Created by Harry Nelken on 2/21/16.
//  Copyright © 2016 CWRU-SP16. All rights reserved.
//

import Foundation

// GLOBAL OBJECTS
let web = WebInterface()
let db = DBInterface()

// SEGUE IDENTIFIERS
let kBookmarkSegueID = "toBookmarks"
let kArticleSegueID = "toArticleDisplay"

// CELL IDENTIFIERS
let kHomeCellID = "homeCell"

// SERVER URL STRINGS
let kServerURL = "http://our server domain here/api/"
let kVerifyUserRoute = "verifyuser"

// DATABASE STRINGS
let kDBName = "hierarchy_test.db"


public extension String {
    var NS: NSString { return (self as NSString) }
}