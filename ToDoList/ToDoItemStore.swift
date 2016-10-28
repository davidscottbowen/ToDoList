//
//  ToDoItemStore.swift
//  ToDoList
//
//  Created by David  Bowen on 10/24/16.
//  Copyright © 2016 David  Bowen. All rights reserved.
//

import UIKit

//class ToDoItemStore to make an instance of data that all files can access

class ToDoItemStore {

    static let shared = ToDoItemStore()
    
    fileprivate var toDos: [[ToDo]] = []
    
    init() {
        let filePath = archiveFilePath()
        let fileManager = FileManager.default
        
        //if file exists
        if fileManager.fileExists(atPath: filePath) {
             toDos = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as! [[ToDo]]
        } else {
            
            //preload toDo rows
            
            for _ in 1...CategoryStore.shared.getCategoryTotal(){
                toDos.append([])
            }
            
            toDos[0] = [ToDo(title: "Ex. Home Item", text: "Ex. Item details")]
            toDos[1] = [ToDo(title: "Ex. Work Item", text: "Ex. Item details")]
            toDos[2] = [ToDo(title: "Ex. Store Item", text: "Ex. Item details")]
            
            save()
        }
        //sort()
    }
    
    // MARK: - Public Functions
    
    func getToDo(_ sectionIndex: Int, rowIndex: Int) -> ToDo {
        return toDos[sectionIndex][rowIndex]
    }
    
    func updateNote(_ rowIndex: Int, toDo: ToDo) {
        toDos[toDo.category] = [toDo]
    }
    
    func addToDo(_ rowIndex: Int, toDo: ToDo) {
        toDos[toDo.category].insert(toDo, at: 0)
    }
    
    func deleteNote(_ rowIndex: Int, _ sectionIndex: Int) {
        toDos[sectionIndex].remove(at: rowIndex)
    }
    
    func getToDoTotal(_ sectionIndex: Int) -> Int {
        return toDos[sectionIndex].count
    }
    
    func save() {
        NSKeyedArchiver.archiveRootObject(toDos, toFile: archiveFilePath())
    }
    
//        func sort() {
//            toDos.sort { (toDo1, toDo2) -> Bool in
//                return toDo1.date.compare(toDo2.date) == .orderedDescending
//            }
//        }
    
    // MARK: - Private Functions
    
    fileprivate func archiveFilePath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths.first!
        let path = (documentsDirectory as NSString).appendingPathComponent("ToDoItemStore.plist")
        return path
    }
}

