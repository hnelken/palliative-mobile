//
//  DBInterface.swift
//  Palliative Mobile
//
//  Created by Harry Nelken on 3/16/16.
//  Copyright © 2016 CWRU-SP16. All rights reserved.
//

import UIKit

class DBInterface: NSObject {

    func getPage(id: Int) -> [String : AnyObject] {
        
        var page: [String : AnyObject] = [ : ]
        let database = FMDatabase(path: dbPath)
        database.open()
        
        let getPageQuery = "SELECT * FROM pages WHERE id=\(id)"
        let getLinksQuery = "SELECT id, link_text FROM pages WHERE parent_id=\(id)"
        
        // Query results
        do {
            var results = try database.executeQuery(getPageQuery, values: [])
            while(results.next()) {
                // Get the page with the given ID
                
                let title = results.stringForColumn("title")
                let subtitle = results.stringForColumn("subtitle")
                let text = results.stringForColumn("text")
                let content = [title, subtitle, text]
                
                page[kPageContentKey] = content
            }
            
            var links: [[AnyObject]] = []
            results = try database.executeQuery(getLinksQuery, values: [])
            while results.next() {
                // Get the children of the given page ID
                
                let link_text = results.stringForColumn("link_text")
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
    
    
    func getAllData() {
        // Getting the database path.
  
        let database = FMDatabase(path: dbPath)
        database.open()
        
        let sqlSelectQuery = "SELECT name FROM sqlite_master WHERE type='table'"
        
        // Query results
        do {
            var count = 0
            let results = try database.executeQuery(sqlSelectQuery, values: [])
            while(results.next()) {
                //let strID = "\(results.intForColumn("ID"))"
                print(results.stringForColumn("name"))
                // loading your data into the array, dictionaries.
                count++
            }
            print(count)
            database.close()
        }
        catch {
            database.close()
        }
        
    }
}
