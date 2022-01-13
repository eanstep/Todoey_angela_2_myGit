//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    //creating UserDefaults
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // not working user defaults because itemArray is collection
        // NSUserDefaults not support collection
        // load UserDefaults
        //if let item = defaults.array(forKey: "TodoListArray") as? [String] {
        //      itemArray = item
        // }
        // if as? [String] - crash protection
        
        let newItem1 = Item()
        newItem1.title = "Find Mike"
        itemArray.append(newItem1)
        
        let newItem2 = Item()
        newItem2.title = "Buy Eggos"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Destroy Demogorgon"
        itemArray.append(newItem3)
    }
    
    //MARK - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row] //refactor code below
        
        cell.textLabel?.text = item.title
        
//        if item.done == true {
//            cell.accessoryType = .checkmark
//        } else {
//            cell.accessoryType = .none
//        }
        
        cell.accessoryType = item.done ? .checkmark : .none //ternary operator replaces if else;
        
        return cell
    }
    
    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Data model are not used
        //if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
        //    tableView.cellForRow(at: indexPath)?.accessoryType = .none
        //} else {
        //    tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        //}
        
//see the refactor code below after the comments
//        if itemArray[indexPath.row].done == false {
//            itemArray[indexPath.row].done = true
//        } else {
//            itemArray[indexPath.row].done = false
//        }
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

    //MARK - Add New Item
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
            
            var textField = UITextField()
            
            let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
                //what will happen once the user clicks the Add Item button on out UIAlert
                
                let newItem = Item()
                
                newItem.title = textField.text!
                
                self.itemArray.append(newItem)
                
                //NotWork not working user defaults because itemArray is collection
                //Save to UserDefaults
                //self.defaults.set(self.itemArray, forKey: "TodoListArray")
               
                self.tableView.reloadData()
            }
            
            alert.addTextField { (alertTextField) in
                alertTextField.placeholder = "Create new item"
                textField = alertTextField
            }
            
            alert.addAction(action)
            
            present(alert, animated: true, completion: nil)
            
        }
    
}

