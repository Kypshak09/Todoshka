//
//  ViewController.swift
//  Todoshka
//
//  Created by Amir Zhunussov on 25.12.2022.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    let label: UILabel = {
        let label =  UILabel()
        label.text = "Todoshka"
        return label
    }()
    @objc func goFunction() {
        navigationController?.pushViewController(CategoryViewController(), animated: true)
    }
    
    let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(goFunction), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-100)
        }
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview().offset(-200)
            make.width.height.equalTo(200)
        }
    }
}
