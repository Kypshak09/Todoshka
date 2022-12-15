//
//  CategoryViewController.swift
//  Todoshka
//
//  Created by Amir Zhunussov on 15.12.2022.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    var categoryArray = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategory()
    }
    
    // MARK: - TableView Datasource Methods
        // display all categories
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
        
    // MARK: - TableView Delegate Method
        //what should happen when we click inside of the category
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell",for: indexPath)
        cell.textLabel?.text = categoryArray[indexPath.row].name
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        context.delete(categoryArray[indexPath.row])
//        categoryArray.remove(at: indexPath.row)
        self.performSegue(withIdentifier: "goToItems", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
        saveCategory()
    }
    
        
    
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "add new category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add category", style: .default) { action in
            let newCategory = Category(context: self.context)
            self.categoryArray.append(newCategory)
            newCategory.name = textField.text!
            self.saveCategory()
            self.tableView.reloadData()
        }
        alert.addAction(action)
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create new Category"
            textField = alertTextField
            
        }
        present(alert,animated: true)
    }
    // MARK: - Data Manipulation Methods
        // save data and load data
    func saveCategory() {
        do {
            try context.save()
        } catch {
            print("Error saving context in category \(error)")
        }
        tableView.reloadData()
    }
    func loadCategory(request: NSFetchRequest<Category> = Category.fetchRequest()) {
        do {
            categoryArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context in category \(error)")
        }
        tableView.reloadData()
    }
}
