//
//  ViewController.swift
//  Todoey
//
//  Created by Psirogiannis Dimitris on 04/12/2019.
//  Copyright © 2019 Psirogiannis Dimitris. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController: UITableViewController{
    
    var todoItems : Results<Item>?
    
    let realm = try! Realm()
    
    var selectedCategory : Category? {
        didSet{
           loadItems()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        
    
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        if let item = todoItems?[indexPath.row] {
            
            cell.textLabel?.text = item.title
            
            cell.accessoryType = item.done ? .checkmark : .none
        
        }else {
        
            cell.textLabel?.text = "No Item Added yet"
        }
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = todoItems?[indexPath.row] {
            do{
                try realm.write {
                    //realm.delete(item)   ->> Realm Delete
                    item.done = !item.done
                }
            }catch{
                print("Error saving done status \(item)")
            }
            
        }
        
        tableView.reloadData()
       
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    @IBAction func addButtonPRessed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) {
            (action) in
            
            
            if let currentCategory = self.selectedCategory {
                
                do {
                    
                    try self.realm.write {
                        
                        let newItem = Item()

                        newItem.title = textField.text!
                        
//                        let timestamp = NSDate().timeIntervalSince1970
                        
                        newItem.created_at = Date()
                        
                        currentCategory.items.append(newItem)
                        
                        
                    }
                    
                }catch {
                    print("Error saving item \(error)")
                }
                
            }
            
            self.tableView.reloadData()
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder  = "Create new ITem"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert,animated: true, completion: nil)
    }
 
    func saveITems (item : Item) {
        
        do{
            
            try realm.write {
                
                realm.add(item)
                
            }
            
        }catch {
           print("Error saving item \(error)")
        }
        
       tableView.reloadData()
        
    }
    
    func loadItems(){
        
        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)

        tableView.reloadData()

    }

    
    
}

//MARK: - Search bar methods
extension TodoListViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "created_at",ascending: false)
        
        tableView.reloadData()

    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            
            loadItems()

            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }

        }
    }

}



