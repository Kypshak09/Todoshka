//
//  CategoryViewController.swift
//  Todoshka
//
//  Created by Amir Zhunussov on 15.12.2022.
//

import UIKit
import CoreData

class MyCell: UITableViewCell {
    @IBOutlet weak var numberOfTask: UILabel!
    
    
}

class CategoryViewController: UITableViewController {

    var categoryArray = [Category]()
    
    var todoList = TodoListViewController()
    
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
    //what should happen when we click inside of the category
override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell",for: indexPath)
    cell.textLabel?.text = categoryArray[indexPath.row].name
//    let cell1 = tableView.dequeueReusableCell(withIdentifier: "CategoryCell") as! MyCell
//
//    cell1.numberOfTask.text = String(todoList.itemArray.count)

//    return cell1
    return cell
}
    // MARK: - TableView Delegate Method

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "goToItems", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
        saveCategory()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArray[indexPath.row]
        }
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .right)
            // для удаления обьектов с экрана и базы данных
            context.delete(categoryArray[indexPath.row])
            categoryArray.remove(at: indexPath.row)
            
            tableView.endUpdates()
            tableView.reloadData()
            saveCategory()
        }
    }
    //MARK: - Add new categories
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "add new category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add category", style: .default) { action in
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!
            self.categoryArray.append(newCategory)
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
