//
//  ToDoTableViewCell.swift
//  ToDoList
//
//  Created by David  Bowen on 10/24/16.
//  Copyright © 2016 David  Bowen. All rights reserved.
//

import UIKit

class ToDoTableViewCell: UITableViewCell {
    @IBOutlet weak var toDoTitle: UILabel!
    @IBOutlet weak var toDoDate: UILabel!
    @IBOutlet weak var toDoDetail: UILabel!
    @IBOutlet weak var toDoModified: UILabel!
    @IBOutlet weak var toDoImage: UIImageView!
    
    var toDo: ToDo!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setUpCell(_ toDo: ToDo) {
        self.toDo = toDo
        toDoTitle.text = toDo.title
        toDoDetail.text = toDo.text
        toDoDate.text = toDo.dateString
        toDoModified.text = "Last modified " + toDo.dateString
        toDoImage.image = toDo.image
    }
}
