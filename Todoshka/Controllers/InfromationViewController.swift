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
    
   

    let textView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 20, weight: .light)
        textView.backgroundColor = .lightGray
        return textView
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "Write your descripton about goal"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    @objc func rightButton() {
        print("is working")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "DescriptionText", in: context)
        let newText = DescriptionText(entity: entity!, insertInto: context)
        newText.text = textView.text
        
        do {
            try context.save()
            textList.append(newText)
            navigationController?.popViewController(animated: true)
        } catch {
            print(error)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(rightButton))
        
        view.addSubview(textView)
        textView.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-100)
            make.centerX.equalToSuperview().offset(0)
            make.width.equalTo(350)
            make.height.equalTo(400)
        }
        
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-330)
            make.width.height.equalTo(400)
        }
    }
}
