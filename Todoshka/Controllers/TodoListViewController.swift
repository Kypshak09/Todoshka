import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadItems()
        
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
        cell.textLabel?.text = itemArray[indexPath.row].title
        // если itemArray true отметь его done если false отметь его none
        itemArray[indexPath.row].done == true ? (cell.accessoryType = .checkmark) : (cell.accessoryType = .none)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // если itemArray true то нажимая на него делай его false а если false то делай его true
        itemArray[indexPath.row].done == true ? (itemArray[indexPath.row].done = false) : (itemArray[indexPath.row].done = true)
        
        saveItem()
        
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
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            
            self.saveItem()
            
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
    
    func saveItem() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding item array , \(error)")
        }
        tableView.reloadData()
    }
    
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("Error encoding item array , \(error) ")
            }
    }
    
}
}
