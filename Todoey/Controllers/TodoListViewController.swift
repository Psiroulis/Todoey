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
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadItems()
       
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
        
        saveITems()
        
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
            
            self.saveITems()
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder  = "Create new ITem"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert,animated: true, completion: nil)
    }
 
    func saveITems () {
        
        let encoder = PropertyListEncoder()
        
        do{
        
            let data = try encoder.encode(itemArray)
            
            try data.write(to: dataFilePath!)
        
        }catch {
            print("Error encoding item array, \(error)")
        }
        
       tableView.reloadData()
        
    }
    
    func loadItems() {
        if let data = try? Data(contentsOf:  dataFilePath!) {
         
            let decoder = PropertyListDecoder()
            
            do {
                
                itemArray = try decoder.decode([ListItem].self, from: data)
                  
            }catch{
                
                print("Error on decoding items \(error)")
                
            }
        }
        
    }
}


