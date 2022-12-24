//
//  TableOfInformation.swift
//  Todoshka
//
//  Created by Amir Zhunussov on 23.12.2022.
//

import UIKit
import CoreData
import SnapKit

var textList = [DescriptionText]()

class TableOfInformation: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var selectedText: DescriptionText? {
        didSet {
            loadItems()
        }
    }
    
    var firstLoad = true
    
// MARK: - table view methods
    let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return textList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        
        let thisText: DescriptionText!
        thisText = textList[indexPath.row]
        cell.label.text = thisText.text
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .right)
            // для удаления обьектов с экрана и базы данных
            context.delete(textList[indexPath.row])
            textList.remove(at: indexPath.row)
            
            tableView.endUpdates()
            tableView.reloadData()
            saveText()
        }
    }
    
  // MARK: - label object
    let labelTextOfDescription: UILabel = {
        let label = UILabel()
        label.text = "something"
        return label
    }()
    // MARK: - add button
    @objc func righButton() {
        navigationController?.pushViewController(InfromationViewController(), animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(firstLoad){
            firstLoad = false
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "DescriptionText")
            do {
                let results: NSArray = try context.fetch(request) as NSArray
                for result in results {
                    let text = result as! DescriptionText
                    textList.append(text)
                }
            }
            catch {
                print("Error fetch \(error)")
            }
        }
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(righButton))
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = .white
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "tableCell")
        
        // MARK: - Table view
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.height.equalToSuperview()
        }
        
    }
    
    func loadItems(request: NSFetchRequest<DescriptionText> = DescriptionText.fetchRequest(), predicate: NSPredicate? = nil) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let categoryPredicate = NSPredicate(format: "new.text MATCHES %@", selectedText!.text!)
        
        if let additionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
        } else {
            request.predicate = categoryPredicate
        }
        
        do {
        textList = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
        tableView.reloadData()
}
    
    func saveText() {
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
        tableView.reloadData()
    }
}
