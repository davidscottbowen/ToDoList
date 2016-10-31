//
//  ToDoListViewController.swift
//  ToDoList
//
//  Created by David  Bowen on 10/24/16.
//  Copyright © 2016 David  Bowen. All rights reserved.
//

import UIKit

class ToDoListViewController: UIViewController {
    
    var completeValue = false

    @IBOutlet weak var editValue: UIBarButtonItem!
    @IBOutlet weak var completeSwitch: UISwitch!
    
    @IBAction func editButton(_ sender: AnyObject) {
        tableView.setEditing(!tableView.isEditing, animated: true)
    }
    @IBAction func completeCheck(_ sender: AnyObject) {
        
        if completeSwitch.isOn {
            completeValue = true
            self.tableView.reloadData()
        } else {
            completeValue = false
            self.tableView.reloadData()
        }
    }

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "editToDoSegue" {
            let ToDoItemVC = segue.destination as! ToDoItemViewController //where we're going, forcing it to be set as a NoteDetailViewController because we know that's what it is
            let tableCell = sender as! ToDoTableViewCell //the cell we clicked on
            ToDoItemVC.toDo = tableCell.toDo //the note in the note detail VC will have the same contents as the cell we clicked on
        }
    }
}


// MARK: - UITableViewCell

extension ToDoListViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        return sourceIndexPath.section == proposedDestinationIndexPath.section ? proposedDestinationIndexPath : sourceIndexPath
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return CategoryStore.shared.getCategoryTotal()
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var categories = CategoryStore.shared.getSections()
        return categories[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ToDoItemStore.shared.getToDoTotal(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing:
            ToDoTableViewCell.self)) as! ToDoTableViewCell
        let currentItem = ToDoItemStore.shared.getToDo(indexPath.section, rowIndex: indexPath.row)
        cell.setUpCell(ToDoItemStore.shared.getToDo(indexPath.section, rowIndex: indexPath.row))
        if completeValue == true {
            if currentItem.complete == true {
                cell.isHidden = true
            } else {
                cell.isHidden = false
            }
        }
        return cell
    }
    
    //     Delete todos
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            ToDoItemStore.shared.deleteNote(indexPath.row, indexPath.section)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            
        }
    }
    
    //     MARK: - Unwind Segue Category Manage
    
    @IBAction func unwindToToDoList(segue: UIStoryboardSegue) {
        tableView.reloadData()
    }
    
    //     MARK: - Unwind Segue Save
    @IBAction func saveToDoItem(_ segue: UIStoryboardSegue) {
        let ToDoItemVC = segue.source as! ToDoItemViewController
        if tableView.indexPathForSelectedRow != nil {
            
            let indexPaths: [IndexPath] = []
            tableView.reloadRows(at: indexPaths, with: .automatic)
            tableView.reloadData()
        } else {
            ToDoItemStore.shared.addToDo(0, toDo: ToDoItemVC.toDo)
            tableView.reloadData()
        }
    }
}
