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
        
        // Look the page up in the database
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let docsPath = paths[0]
        let dbPath = docsPath.NS.stringByAppendingPathComponent(kDBName)
        
        let database = FMDatabase(path: dbPath)
        database.open()
        
        let sqlSelectQuery = "SELECT * FROM pages WHERE id=\(id)"
        
        // Query results
        do {
            let results = try database.executeQuery(sqlSelectQuery, values: [])
            while(results.next()) {
                let strID = "\(results.intForColumn(results.columnNameForIndex(0)))"
                
                // loading your data into the array, dictionaries.
                print("ID = \(strID)")
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
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let docsPath = paths[0]
        let dbPath = docsPath.NS.stringByAppendingPathComponent(kDBName)
    
        let database = FMDatabase(path: dbPath)
        database.open()
        
        let sqlSelectQuery = "SELECT * FROM 'pages'"
    
        // Query results
        do {
            
            try database.executeStatements("CREATE TABLE pages")
            let resultsWithNameLocation = try database.executeQuery(sqlSelectQuery, values: [])
            while(resultsWithNameLocation.next()) {
                let strID = "\(resultsWithNameLocation.intForColumn("ID"))"
    
                // loading your data into the array, dictionaries.
                print("ID = \(strID)")
            }
            database.close()
        }
        catch {
            database.close()
        }
        
    }
}
