//
//  CategoryStore.swift
//  ToDoList
//
//  Created by David  Bowen on 10/27/16.
//  Copyright © 2016 David  Bowen. All rights reserved.
//

import UIKit

//class ToDoItemStore to make an instance of data that all files can access

class CategoryStore {
    
    static let shared = CategoryStore()
    var category: [Category] = []
    
    init() {
        let filePath = archiveFilePath()
        let fileManager = FileManager.default
        
        //if the file exists
        if fileManager.fileExists(atPath: filePath) {
            //pull the info from the file and put it into our note array
            category = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as! [Category]
        } else {
            //preload some category sections
            category.append(Category(title: "Home"))
            category.append(Category(title: "Work"))
            category.append(Category(title: "Store"))
            
            save()
        }
    }
    
    // MARK: - Public Functions
    
    func getCategoryTotal() -> Int {
        return category.count
    }
    func getCategory(row: Int) -> String{
        return category[row].title
    }
    func getSections() -> [String]{
        var sectionArray = [String]()
        if ((category.count - 1) >= 0) {
            for i in 0...category.count - 1{
                sectionArray.append(category[i].title)
            }
        }
        return sectionArray
    }
    
    func removeCategory(_ index: Int) {
        category.remove(at: index)
        save()
    }
    
    // save function
    func save() {
        NSKeyedArchiver.archiveRootObject(category, toFile: archiveFilePath())
    }
    
    // MARK: - save plist function
    
    fileprivate func archiveFilePath() -> String {
        //asking for our app's document path for the current user (userDomainMask) and expands tildes so we get the full file path (in IOS it will always give us one path, but returns an array of paths)
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        //convering the array of path strings (of which there is only one) into a single string
        let documentsDirectory = paths.first!
        //adding notestore.plist (property list) to our app path. The plist will contain our stored note information
        let path = (documentsDirectory as NSString).appendingPathComponent("CategoryStore.plist") //can use as without ! or ? because of toll free bridging between String and NSString
        //returning the path containing plist
        return path
    }
}
