//
//  CategoryEditTableViewController.swift
//  ToDoList
//
//  Created by David  Bowen on 10/29/16.
//  Copyright © 2016 David  Bowen. All rights reserved.
//

import UIKit

class CategoryEditTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func done(_ sender: AnyObject) {
        self.performSegue(withIdentifier: "unwindToToDoList", sender: self)
    }
    
    @IBAction func unwindToCategoryEdit(segue: UIStoryboardSegue) {
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return CategoryStore.shared.getCategoryTotal()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryEditCell", for: indexPath)
        
        cell.textLabel?.text = CategoryStore.shared.getCategory(row: indexPath.row)
        return cell
    }
 
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            CategoryStore.shared.removeCategory(indexPath.row)
            ToDoItemStore.shared.removeSection(indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
