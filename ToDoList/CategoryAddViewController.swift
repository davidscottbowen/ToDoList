//
//  CategoryAddViewController.swift
//  ToDoList
//
//  Created by David  Bowen on 10/30/16.
//  Copyright © 2016 David  Bowen. All rights reserved.
//

import UIKit

class CategoryAddViewController: UIViewController {
    
    @IBOutlet weak var addCategory: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addNewCategory(_ sender: AnyObject) {
        CategoryStore.shared.category.append(Category(title: addCategory.text!))
        ToDoItemStore.shared.addNewSection()
        CategoryStore.shared.save()
        ToDoItemStore.shared.save()
        self.performSegue(withIdentifier: "unwindToCategoryEdit", sender: self)
    }
}


