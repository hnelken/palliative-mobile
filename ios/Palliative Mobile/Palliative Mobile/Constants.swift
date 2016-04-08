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
let kHomeSegueID = "toHome"
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
let kPalliativePerformanceCellID = "palliativePerformanceCell"
let kKarnofskyCellID = "karnofskyCell"
let kActivityCellID = "activityCell"
let kSelfCareCellID = "selfCareCell"
let kIntakeCellID = "inatkeCell"
let kConsciousCellID = "consciousCell"
let kBookmarkCellID = "bookmarkCell"
let kArticleLinkCellID = "articleLinkCell"
let kSearchCellID = "searchCell"

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