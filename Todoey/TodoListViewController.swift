//
//  ViewController.swift
//  Todoey
//
//  Created by Psirogiannis Dimitris on 04/12/2019.
//  Copyright © 2019 Psirogiannis Dimitris. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    let itemArray = ["one", "two", "three"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print("You select \(itemArray[indexPath.row])")
        
        if( tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCell.AccessoryType.none){
            
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        
        }else{
        
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}

