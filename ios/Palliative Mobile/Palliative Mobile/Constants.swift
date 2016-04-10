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

// PAGE ID CONSTANTS
let kRapidPCPageID = 2
let kCareForFrailPageID = 51

// SEGUE IDENTIFIERS
let kHomeSegueID = "toHome"
let kSurveySegueID = "toSurvey"
let kRapidPCSegueID = "toRapidPC"
let kBookmarkSegueID = "toBookmarks"
let kArticleSegueID = "toArticleDisplay"
let kFirstTimeSegueID = "toFirstTime"
let kUnstableSegueID = "toUnstable"
let kShowBookmarkSegueID = "displayBookmark"
let kShowSearchSegueID = "showSearchResults"
let kShowSearchResultSegueID = "displaySearchResult"

// CELL IDENTIFIERS
let kHomeCellID = "homeCell"
let kBookmarkCellID = "bookmarkCell"
let kArticleLinkCellID = "articleLinkCell"
let kSearchCellID = "searchCell"

// STORYBOARD IDS
let kPageContentControllerID = "PageContentController"
let kPageViewControllerID = "PageViewController"
let kFirstTimePageID = "FirstTimePage"
let kOptOutPageID = "OptOutPage"

// SERVER URL CONSTANTS
let kServerURL = "http://our server domain here/api/"
let kVerifyUserRoute = "verifyuser"

// DATABASE CONSTANTS
let kDBName = "master_local.db"
let kLinkNameIndex = 0
let kLinkIDIndex = 1
let kContentTitleIndex = 0
let kContentSubtitleIndex = 1
let kContentTextIndex = 2
let kPageParentIDKey = "parentID"
let kPageContentKey = "content"
let kPageLinksKey = "links"
let kPageBookmarkedKey = "bookmarked"

var dbPath: String {
    let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
    let docsPath = paths[0]
    let dbPath = docsPath.NS.stringByAppendingPathComponent(kDBName)
    return dbPath
}


public extension String {
    var NS: NSString { return (self as NSString) }
}