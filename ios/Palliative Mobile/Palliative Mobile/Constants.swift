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
let kRapidPCSegueID = "toRapidPC"
let kBookmarkSegueID = "toBookmarks"
let kArticleSegueID = "toArticleDisplay"
let kFirstTimeSegueID = "toFirstTime"
let kUnstableSegueID = "toUnstable"

// CELL IDENTIFIERS
let kHomeCellID = "homeCell"
let kArticleLinkCellID = "articleLinkCell"

// SERVER URL CONSTANTS
let kServerURL = "http://our server domain here/api/"
let kVerifyUserRoute = "verifyuser"

// DATABASE CONSTANTS
let kDBName = "hierarchy_test.db"
let kLinkNameIndex = 0
let kLinkIDIndex = 1
let kContentTitleIndex = 0
let kContentSubtitleIndex = 1
let kContentTextIndex = 2
let kPageContentKey = "content"
let kPageLinksKey = "links"


public extension String {
    var NS: NSString { return (self as NSString) }
}