import UIKit
import CoreData

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()
    
    var selectedCategory: Category? {
        didSet {
            loadItems()
        }
    }
    
    // чтобы обратиться к Appdelegate откуда мы вытаскиваем дату для controller, мы используем singleton обращаясь к UIApplication, shared значит мы обращаемся именно к приложению которое запущенно. Короче говоря мы теперь имеем доступ к AppDelegate как обьекту
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem?.tintColor = .black
    }
    
    
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .right)
            // для удаления обьектов с экрана и базы данных
            context.delete(itemArray[indexPath.row])
            itemArray.remove(at: indexPath.row)
            
            tableView.endUpdates()
            tableView.reloadData()
            saveItem()
        }
    }
    
    // MARK: - Table view number of rows
        // метод выводящий количество клеток
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //количество клеток. зависит от array
        return itemArray.count
    }
    // MARK: - Table view do cell
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
    //MARK: - Table view did select row at
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // для удаления обьектов с экрана и базы данных
//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)
        // если itemArray true то нажимая на него делай его false а если false то делай его true
        itemArray[indexPath.row].done == true ? (itemArray[indexPath.row].done = false) : (itemArray[indexPath.row].done = true)
        
        if itemArray[indexPath.row].done == true  {
            let alert = UIAlertController(title: "Yeah boooy", message: "Super", preferredStyle: .alert)
            let action = UIAlertAction(title: "Go to next goal", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        } else if itemArray[indexPath.row].done == false {
            let alert = UIAlertController(title: "JUST DO IT!", message: "LET'S GOOO", preferredStyle: .alert)
            let action = UIAlertAction(title: "YOU CAN DO IT", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    
        saveItem()
        
        // нажимая на cell, он просто моргает серым и становится таким же как и был
        tableView.deselectRow(at: indexPath, animated: true)
    }
    // MARK: - Add button
    
    @IBAction func addButton(_ sender: UIBarButtonItem) {
        // переменная для того чтобы использовать из text field text в action
        var textField = UITextField()
        
        // создаем окно которое будет controller-ом нашего окна
        let alert = UIAlertController(title: "add new item", message: "", preferredStyle: .alert)
        
        // создает кнопку с помощью нашего окна для добавлянения новых cell-ов
        let action = UIAlertAction(title: "Add item", style: .default) { action in
            // context вещь через которую мы обращаемся к базе данных и сохраняем там наши значения, Item class создается автоматически с помощью Datamodel, в нем есть entity Item и это его класс
            let newItem = Item(context: self.context)
            // добавляет новый элемент
            self.itemArray.append(newItem)
            newItem.title = textField.text!
            // изначально когда создается новый элемент он будет не сделан
            newItem.done = false
            // сохранить значение новое. self потому что он  в closure
            newItem.parentCategory = self.selectedCategory
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
    
    //MARK: - function saving new items
    // функция сохрающая новые задания
    func saveItem() {
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
        tableView.reloadData()
    }
    // MARK: - function loading new items
    func loadItems(request: NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil) {
        
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        
        if let additionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
        } else {
            request.predicate = categoryPredicate
        }
        
        do {
        itemArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
        tableView.reloadData()
}
    
    // MARK: - description button
    @IBAction func informationButton(_ sender: UIButton) {
        navigationController?.pushViewController(TableOfInformation(), animated: true)
    }
}


// MARK: - Search Bar methods
extension TodoListViewController: UISearchBarDelegate  {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        loadItems(request: request, predicate: predicate)
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
