//
//  TableOfInformation.swift
//  Todoshka
//
//  Created by Amir Zhunussov on 23.12.2022.
//

import UIKit
import CoreData
import SnapKit

class TableOfInformation: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
// MARK: - table view methods
    let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        return cell
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
}
