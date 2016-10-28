//
//  CategoryClass.swift
//  ToDoList
//
//  Created by David  Bowen on 10/27/16.
//  Copyright © 2016 David  Bowen. All rights reserved.
//

import UIKit

class Category: NSObject, NSCoding {
    var title = ""
    
    //these are keys for encoding and decoding
    let titleKey = "title"
    
    //Decoding 
    
    required init?(coder aDecoder: NSCoder) {
        self.title = aDecoder.decodeObject(forKey: titleKey) as! String
    }
    
    //Encoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: titleKey)
    }
    
    //blank initializer
    override init() {
        super.init()
    }
    
    //more robust initializer
    init(title: String) {
        self.title = title
    }
    
}

