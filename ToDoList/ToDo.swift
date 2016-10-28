//
//  ToDo.swift
//  ToDoList
//
//  Created by David  Bowen on 10/24/16.
//  Copyright © 2016 David  Bowen. All rights reserved.
//

import UIKit

class ToDo: NSObject, NSCoding {
    var title = ""
    var text = ""
    var date = Date()
    var category = 0
    var complete = false
    var dateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
        return dateFormatter.string(from: date)
    }
    var modified = Date()
    var image: UIImage?

    //Keys for saving
    let titleKey = "title"
    let textKey = "text"
    let dateKey = "date"
    let completeKey = "complete"
    let imageKey = "image"
    let modifiedKey = "modified"
    
    //persistance
    
    //Decoding
    required init?(coder aDecoder: NSCoder) {
        self.title = aDecoder.decodeObject(forKey: titleKey) as! String
        self.text = aDecoder.decodeObject(forKey: textKey) as! String
        self.date = aDecoder.decodeObject(forKey: dateKey) as! Date
        self.complete = aDecoder.decodeBool(forKey: completeKey)
        self.modified = aDecoder.decodeObject(forKey: modifiedKey) as! Date
        self.image = aDecoder.decodeObject(forKey: imageKey) as? UIImage
        
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: titleKey)
        aCoder.encode(text, forKey: textKey)
        aCoder.encode(date, forKey: dateKey)
        aCoder.encode(complete, forKey: completeKey)
        aCoder.encode(image, forKey: imageKey)
        aCoder.encode(modified, forKey: modifiedKey)
    }
    
    //blank initializer
    override init() {
        super.init()
    }
    
    //initializer
    init(title: String, text: String) {
        self.title = title
        self.text = text
    }
}
