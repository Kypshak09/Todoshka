//
//  ViewController.swift
//  Todoshka
//
//  Created by Amir Zhunussov on 12.12.2022.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = ["Find milk", "Calisma", "Work"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UINavigationBar.appearance().barTintColor = UIColor.orange
    }
        // метод выводящий количество клеток
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //количество клеток. зависит от array
        return itemArray.count
    }
    // метод для отображения клеток на tableView
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // создаем клетку в tableView и обращаемся к ней
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        // даем ей значени из нашего array
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // нажимая на cell будет отображаться checkmark
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        } 
        
        // нажимая на cell, он просто моргает серым и становится таким же как и был
        tableView.deselectRow(at: indexPath, animated: true)
    }

    
    
    @IBAction func addButton(_ sender: UIBarButtonItem) {
        // переменная для того чтобы использовать из text field text в action
        var textField = UITextField()
        
        // создаем окно которое будет controller-ом нашего окна
        let alert = UIAlertController(title: "add new item", message: "", preferredStyle: .alert)
        
        // создает кнопку с помощью нашего окна для добавлянения новых cell-ов
        let action = UIAlertAction(title: "Add item", style: .default) { action in
            // добавляет в array новый элеменет который создали в alert
            self.itemArray.append(textField.text!)
            // обновляет таблицу чтобы увидеть новые cells
            self.tableView.reloadData()
        }
        //активируем метод action
        alert.addAction(action)
        
        
        //добавляет в наше окно textField чтобы писать что мы хотим добавить в tableView
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create new item" // Создаем placeholder(текст в textField что нужно писать в окно)
            
           // приравнивает texfield к alertTextField, к тексту который пользователь вводит
            textField = alertTextField
        }
        // меторд present делает чтобы отобржалось окно
        present(alert, animated: true)
    }
    
}

