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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    

    let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    @objc func righButton() {
        navigationController?.pushViewController(InfromationViewController(), animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(righButton))
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.height.equalToSuperview()
        }
        
    }
}
