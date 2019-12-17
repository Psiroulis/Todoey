//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by Psirogiannis Dimitris on 11/12/2019.
//  Copyright © 2019 Psirogiannis Dimitris. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryTableViewController: UITableViewController {
    
    let realm = try! Realm()

    var categoryArray : Results<Category>?
    
//    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        loadCategory()
       
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categoryArray?.count ?? 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categoryArray?[indexPath.row].name ?? "No Categories Added Wet"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        let destinastionVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinastionVC.selectedCategory = categoryArray?[indexPath.row]
        }
    
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Todey category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) {
            (action) in
            
            let newCategory = Category()
            
            newCategory.name = textField.text!
            
            self.saveCategory(category: newCategory)
            
        }
        
        alert.addTextField {
            (alertTextField) in
            
            alertTextField.placeholder = "Create new Category"
            
            textField = alertTextField
        
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    func loadCategory() {
        
        categoryArray = realm.objects(Category.self)
        
        tableView.reloadData()
    }
    
    func saveCategory(category : Category)  {
        
        do {
            try realm.write {
                realm.add(category)
            }
        }catch {
            print("Error saving category \(error)")
        }
        
        tableView.reloadData()
    
    }
    
}
