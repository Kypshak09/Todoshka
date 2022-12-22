//
//  InfromationViewController.swift
//  Todoshka
//
//  Created by Amir Zhunussov on 22.12.2022.
//

import UIKit
import SnapKit
import CoreData

class InfromationViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
//    let buttonRight: UIBarButtonItem = {
//        let button = UIBarButtonItem()
//        button.tintColor = .black
//        button.setBackgroundImage(UIImage(systemName: "add"), for: .normal, barMetrics: .default)
//        return button
//    }()
    
//    let buttonRightCorner: UIButton = {
//        let button = UIButton()
//        button.tintColor = .black
//        button.setImage(UIImage(systemName: "add"), for: .normal)
//        return button
//    }()
//
    let textField: UITextView = {
        let textField = UITextView()
        textField.font = .systemFont(ofSize: 20, weight: .light)
        return textField
    }()
    
    @objc func rightButton() {
        print("is working")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(rightButton))
        
        view.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-200)
            make.centerX.equalToSuperview().offset(-50)
            make.width.equalTo(300)
            make.height.equalTo(400)
        }
//        view.addSubview(buttonRight)
//        buttonRight.snp.makeConstraints { make in
//            make.centerX.equalToSuperview().offset(300)
//            make.centerY.equalToSuperview().offset(100)
//            make.width.height.equalTo(100)
//        }
    }
    
    
    
    func save() {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.saveContext()
        }
    }
    
}
