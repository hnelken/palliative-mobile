//
//  DBInterface.swift
//  Palliative Mobile
//
//  Created by Harry Nelken on 3/16/16.
//  Copyright © 2016 CWRU-SP16. All rights reserved.
//

import UIKit

class DBInterface: NSObject {

    // Gets a dictionary containing a specified page's info from the DB
    func getPage(id: Int) -> [String : AnyObject] {
        
        var page: [String : AnyObject] = [ : ]
        let database = FMDatabase(path: dbPath)
        database.open()
        
        let getPageQuery = "SELECT * FROM pages WHERE id=\(id)"
        let getLinksQuery = "SELECT id, title FROM pages WHERE parent_id=\(id)"
        
        // Query results
        do {
            var results = try database.executeQuery(getPageQuery, values: [])
            while results.next() {
                // Get the page with the given ID
                
                let title = results.stringForColumn("title")
                //print(title)
                
                let text = results.stringForColumn("text")
                let detail = results.stringForColumn("detail")
                let parentID = results.intForColumn("parent_id")
                let content = [title, text, detail]
                let bookmarked = results.intForColumn("is_bookmarked")
                
                page[kPageContentKey] = content
                page[kPageParentIDKey] = NSNumber(int: parentID)
                page[kPageBookmarkedKey] = NSNumber(int: bookmarked)
            }
            
            // Update this pages hits
            addPageHit(id)
            
            var links: [[AnyObject]] = []
            results = try database.executeQuery(getLinksQuery, values: [])
            while results.next() {
                // Get the children of the given page ID
                let link_text = results.stringForColumn("title")
                //print(link_text)
                let link_id = NSNumber(int: results.intForColumn("id"))
                let link: [AnyObject] = [link_text, link_id]
                links.append(link)
            }
            
            page[kPageLinksKey] = links
            
            database.close()
        }
        catch {
            database.close()
        }
        
        return page
    }
    
    // Inserts or removes bookmark in database
    func commitBookmarkChanges(bookmarked: Bool, pageID: Int) {
        let database = FMDatabase(path: dbPath)
        database.open()
        
        // Update the page
        do {
            if bookmarked {
                let insertBookmarkQuery: String = "INSERT INTO bookmarks (page_id) VALUES (\(pageID))"
                try database.executeUpdate(insertBookmarkQuery, values: [])

                // Update row in pages table to show page is bookmarked
                let bookmarkQuery: String = "UPDATE pages SET is_bookmarked = \(1) WHERE id = \(pageID)";
                try database.executeUpdate(bookmarkQuery, values: [])
            }
            else {
                let deleteBookmarkQuery: String = "DELETE FROM bookmarks WHERE page_id = (\(pageID))"
                try database.executeUpdate(deleteBookmarkQuery, values: [])
                
                // Update row in pages table to show page is bookmarked
                let bookmarkQuery: String = "UPDATE pages SET is_bookmarked = \(0) WHERE id = \(pageID)";
                try database.executeUpdate(bookmarkQuery, values: [])
            }
            
            database.close()
        }
        catch {
            database.close()
        }
        
    }
    
    // Retrieves all bookmarks as links
    func getBookmarks() -> [[AnyObject]] {
        var bookmarks: [[AnyObject]] = []
        let database = FMDatabase(path: dbPath)
        database.open()
        
        // Get all bookmarks of the form [Link text, page id]
        do {
            let getBookmarksQuery: String = "SELECT page_id FROM bookmarks"
            let results = try database.executeQuery(getBookmarksQuery, values: [])
            
            while results.next() {
                let pageID = NSNumber(int: results.intForColumn("page_id"))
                let getBookmarksQuery: String = "SELECT title FROM pages WHERE id=\(pageID)"
                let pages = try database.executeQuery(getBookmarksQuery, values: [])
                while pages.next() {
                    let text = pages.stringForColumn("title")
                    let bookmark = [text, pageID]
                    bookmarks.append(bookmark)
                }
            }
            database.close()
        }
        catch {
            database.close()
        }
        return bookmarks
    }
    
    // Performs search and returns all results as links
    func performSearch(query: String) -> [[AnyObject]] {
        var searchResults: [[AnyObject]] = []
        let database = FMDatabase(path: dbPath)
        database.open()
        
        // Get all bookmarks of the form [Link text, page id]
        do {
            let titleSearch = "title LIKE '%\(query)%' OR "
            let textSearch = "text LIKE '%\(query)%' OR "
            let detailSearch = "detail LIKE '%\(query)%'"

            let searchQuery = "SELECT id, title FROM pages WHERE \(titleSearch)\(textSearch)\(detailSearch)"
            let results = try database.executeQuery(searchQuery, values: [])
            
            while results.next() {
                let pageID = NSNumber(int: results.intForColumn("id"))
                let text = results.stringForColumn("title")
                let searchResult = [text, pageID]
                searchResults.append(searchResult)
            }
            database.close()
        }
        catch {
            database.close()
        }
        return searchResults
    }
    
    // Add a "hit" to a page in the DB
    func addPageHit(pageID: Int) {
        let database = FMDatabase(path: dbPath)
        database.open()
        
        do {
            var hits = 0
            let getPageHitsQuery: String = "SELECT * FROM page_hits WHERE page_id=\(pageID)"
            let results = try database.executeQuery(getPageHitsQuery, values: [])
            while results.next() {
                hits = Int(results.intForColumn("hits"))
            }
            
            if hits > 0 {
                let addPageHitQuery: String = "UPDATE page_hits SET hits=\(hits + 1) WHERE page_id=\(pageID)"
                try database.executeUpdate(addPageHitQuery, values: [])
            }
            else {
                let addPageHitQuery: String = "INSERT INTO page_hits (page_id, hits) VALUES (\(pageID), 1);"
                try database.executeUpdate(addPageHitQuery, values: [])
            }
            
            database.close()
        }
        catch {
            database.close()
        }
    }
    
    // Assembles the page hit rows into a dictionary
    func getPageHits() -> [String:Int] {
        var hits: [String:Int] = [ : ]
        
        let database = FMDatabase(path: dbPath)
        database.open()
        
        do {
            let clearPageHitsQuery: String = "SELECT * FROM page_hits"
            let results = try database.executeQuery(clearPageHitsQuery, values: [])
            
            while results.next() {
                let pageID = results.intForColumn("page_id")
                hits["\(pageID)"] = Int(results.intForColumn("hits"))
            }
            
            database.close()
        }
        catch {
            database.close()
        }
        print("Hits: \(hits.count)")
        return hits
    }
    
    // Reset all page hit counts
    func clearPageHits() {
        let database = FMDatabase(path: dbPath)
        database.open()
        
        do {
            let clearPageHitsQuery: String = "DELETE FROM page_hits"
            try database.executeUpdate(clearPageHitsQuery, values: [])
            database.close()
        }
        catch {
            database.close()
        }
    }
    
    // Commits that the user skipped the survey
    func optOut() {
        let database = FMDatabase(path: dbPath)
        database.open()
        
        do {
            let optOutQuery: String = "INSERT INTO settings (name, value) VALUES (\"opt_out\", 1)"
            try database.executeUpdate(optOutQuery, values: [])
            database.close()
        }
        catch {
            database.close()
        }
    }
    
    // Commits that the user latently opted in to the survey
    func optIn() {
        let database = FMDatabase(path: dbPath)
        database.open()
        
        do {
            let optInQuery: String = "DELETE FROM settings WHERE name=\"opt_out\""
            try database.executeUpdate(optInQuery, values: [])
            database.close()
        }
        catch {
            database.close()
        }
    }
    
    // Determine if the user opted out of the survey
    func getOptOutStatus() -> Bool {
        let database = FMDatabase(path: dbPath)
        database.open()
        
        do {
            let optOutQuery: String = "SELECT value FROM settings WHERE name=\"opt_out\""
            let results = try database.executeQuery(optOutQuery, values: [])
            while results.next() {
                print("OptOutFromDB: \(results.boolForColumn("value"))")
                return results.boolForColumn("value")
            }
            database.close()
        }
        catch {
            database.close()
        }
        
        print("No Db Opt Out: false")
        return false
    }
    
    // Add user demographic info to the DB
    func commitUserInfo(device: String, age: Int, postGrad: Bool, years: Int, cert: String, prac: String) {
        let database = FMDatabase(path: dbPath)
        database.open()
        
        do {
            let isPostGrad = NSNumber(bool: postGrad).integerValue
            let deviceUpdate: String =
                "INSERT INTO settings (name, value) VALUES (\"device\", \"\(device)\")"
            let ageUpdate: String =
                "INSERT INTO settings (name, value) VALUES (\"age\", \(age))"
            let postGradUpdate: String =
                "INSERT INTO settings (name, value) VALUES (\"postGrad\", \(isPostGrad))"
            let yearsUpdate: String =
                "INSERT INTO settings (name, value) VALUES (\"years\", \(years))"
            let certUpdate: String =
                "INSERT INTO settings (name, value) VALUES (\"certification\", \"\(cert)\")"
            let pracUpdate: String =
                "INSERT INTO settings (name, value) VALUES (\"practice\", \"\(prac)\")"
            
            try database.executeUpdate(deviceUpdate, values: [])
            try database.executeUpdate(ageUpdate, values: [])
            try database.executeUpdate(postGradUpdate, values: [])
            try database.executeUpdate(yearsUpdate, values: [])
            try database.executeUpdate(certUpdate, values: [])
            try database.executeUpdate(pracUpdate, values: [])
            
            database.close()
        }
        catch {
            database.close()
        }
    }
    
    // Returns a dictionary of the user's demographics from the survey
    func getCredentials() -> [String:String] {
        let database = FMDatabase(path: dbPath)
        database.open()
        
        var creds: [String:String] = [ : ]
        do {
            let deviceUpdate: String = "SELECT value FROM settings WHERE name=\"device\""
            let ageUpdate: String = "SELECT value FROM settings WHERE name=\"age\""
            let postGradUpdate: String = "SELECT value FROM settings WHERE name=\"postGrad\""
            let yearsUpdate: String = "SELECT value FROM settings WHERE name=\"years\""
            let certUpdate: String = "SELECT value FROM settings WHERE name=\"certification\""
            let pracUpdate: String = "SELECT value FROM settings WHERE name=\"practice\""
            
            var results = try database.executeQuery(deviceUpdate, values: [])
            while results.next() {
                creds["device"] = results.stringForColumn("value")
            }
            
            results = try database.executeQuery(ageUpdate, values: [])
            while results.next() {
                creds["age"] = results.stringForColumn("value")
            }
            
            results = try database.executeQuery(postGradUpdate, values: [])
            while results.next() {
                creds["postGrad"] = results.stringForColumn("value")
            }
            
            results = try database.executeQuery(yearsUpdate, values: [])
            while results.next() {
                creds["years"] = results.stringForColumn("value")
            }
            
            results = try database.executeQuery(certUpdate, values: [])
            while results.next() {
                creds["certification"] = results.stringForColumn("value")
            }
            
            results = try database.executeQuery(pracUpdate, values: [])
            while results.next() {
                creds["practice"] = results.stringForColumn("value")
            }
            
            database.close()
        }
        catch {
            database.close()
        }
        print(creds)
        return creds
    }
    
    // Executes arbitrary updates received from the master server
    func executeUpdate(sql: String) {
        let database = FMDatabase(path: dbPath)
        database.open()
        
        do {
            try database.executeUpdate(sql, values: [])
            database.close()
        }
        catch {
            database.close()
        }
    }
    
    // Updates the DB version after new updates
    func updateVersion(version: Int) {
        let database = FMDatabase(path: dbPath)
        database.open()
        
        do {
            let verUpdateQuery: String
            if version == 0 {
                verUpdateQuery = "INSERT INTO settings (name, value) VALUES (\"version\", \(version))"
            }
            else {
                verUpdateQuery = "UPDATE settings SET value=\(version) WHERE name=\"version\""
            }
            try database.executeUpdate(verUpdateQuery, values: [])
            database.close()
        }
        catch {
            database.close()
        }
    }
    
    func getVersionNumber() -> Int {
        let database = FMDatabase(path: dbPath)
        database.open()
        
        do {
            // Query for the version setting set on first launch
            let versionQuery = "SELECT value FROM settings WHERE name=\"version\""
            let results = try database.executeQuery(versionQuery, values: [])
            while results.next() {
                return Int(results.intForColumn("value"))
            }
            database.close()
        }
        catch {
            database.close()
        }
        
        // Give base database version
        return 0
    }
    
    // Check if the app has not been initialized yet
    func getFirstTimeStatus() -> Bool {
        let database = FMDatabase(path: dbPath)
        database.open()
        var firstTime: Bool = false
        do {
            let firstTimeQuery = "SELECT * FROM settings WHERE name=\"first_time\""
            let results = try database.executeQuery(firstTimeQuery, values: [])
            while results.next() {
                firstTime = true
            }
            database.close()
        }
        catch {
            database.close()
        }
        return firstTime
    }
    
    // Set the app to "first time" status
    func setFirstTimeTrue() {
        let database = FMDatabase(path: dbPath)
        database.open()
        
        do {
            let firstTimeQuery = "INSERT INTO settings (name, value) VALUES (\"first_time\", 1)"
            try database.executeUpdate(firstTimeQuery, values: [])
            database.close()
        }
        catch {
            database.close()
        }
    }
    
    // Release the app from the "first time" status
    func releaseFirstTime() {
        let database = FMDatabase(path: dbPath)
        database.open()
        
        do {
            let releaseQuery = "DELETE FROM settings WHERE name=\"first_time\""
            try database.executeUpdate(releaseQuery, values: [])
            database.close()
        }
        catch {
            database.close()
        }
    }
}
