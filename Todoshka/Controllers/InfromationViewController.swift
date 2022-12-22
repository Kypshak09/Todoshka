//
//  InfromationViewController.swift
//  Todoshka
//
//  Created by Amir Zhunussov on 22.12.2022.
//

import UIKit
import SnapKit

class InfromationViewController: UIViewController {

    let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter information about your goal"
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
            make.height.width.equalTo(200)
        }
    }
}
