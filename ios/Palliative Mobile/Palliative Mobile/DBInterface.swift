//
//  DBInterface.swift
//  Palliative Mobile
//
//  Created by Harry Nelken on 3/16/16.
//  Copyright © 2016 CWRU-SP16. All rights reserved.
//

import UIKit

class DBInterface: NSObject {

    func getPage(id: Int32) -> [String : AnyObject] {
        let page = [
            kPageContentKey : [ "Title", "Subtitle", "Content/Description"],
            kPageLinksKey : [["LinkTitle", 0], ["LinkTitle2", 1]]
        ]
        
        let database = FMDatabase(path: dbPath)
        database.open()
        
        let sqlSelectQuery = "SELECT * FROM pages WHERE id=\(id)"
        
        // Query results
        do {
            let results = try database.executeQuery(sqlSelectQuery, values: [])
            while(results.next()) {
                
                // loading your data into the array, dictionaries.
                print("Title = \(results.stringForColumn("title"))")
            }
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
