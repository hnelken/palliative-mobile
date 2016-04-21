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
                let subtitle = results.stringForColumn("subtitle")
                let text = results.stringForColumn("text")
                let content = [title, subtitle, text]
                
                let bookmarked = results.intForColumn("is_bookmarked")
                
                page[kPageContentKey] = content
                page[kPageBookmarkedKey] = NSNumber(int: bookmarked)
            }
            
            var links: [[AnyObject]] = []
            results = try database.executeQuery(getLinksQuery, values: [])
            while results.next() {
                // Get the children of the given page ID
                
                let link_text = results.stringForColumn("title")//"link_text")
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
                    let text = pages.stringForColumn("title")//"link_text")
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
            let subtitleSearch = "subtitle LIKE '%\(query)%' OR "
            let textSearch = "text LIKE '%\(query)%'"

            let searchQuery = "SELECT * FROM pages WHERE \(titleSearch)\(subtitleSearch)\(textSearch)"
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
    
}
