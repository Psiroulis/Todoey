//
//  ViewController.swift
//  Todoey
//
//  Created by Psirogiannis Dimitris on 04/12/2019.
//  Copyright © 2019 Psirogiannis Dimitris. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = [ListItem]()
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()

        let newItem = ListItem(todo : "one", checked : true)
        itemArray.append(newItem)

        let newItem2 = ListItem(todo : "two", checked : false)
        itemArray.append(newItem2)

        let newItem3 = ListItem(todo : "three", checked : false)
        itemArray.append(newItem3)
        
     
//        let data = defaults.data(forKey: "TodoListArray")
//
//        if  data != nil {
//
//            itemArray = try! JSONDecoder().decode([ListItem].self, from: data!)
//
//        }
       
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.getTodo()
        
        cell.accessoryType = item.getCheckedState() ? .checkmark : .none
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print("You select \(itemArray[indexPath.row])")
        
        itemArray[indexPath.row].setChecked(checked: !itemArray[indexPath.row].getCheckedState())
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    @IBAction func addButtonPRessed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) {
            (action) in
            
            let newItem = ListItem(todo : textField.text!, checked : false)
            
            self.itemArray.append(newItem)
            
            let data = try! JSONEncoder().encode(self.itemArray)
            
            self.defaults.set(data, forKey: "TodoListArray")
           
            
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder  = "Create new ITem"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert,animated: true, completion: nil)
    }
    
}


