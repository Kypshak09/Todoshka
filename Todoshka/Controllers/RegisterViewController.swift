//
//  RegisterViewController.swift
//  Todoshka
//
//  Created by Amir Zhunussov on 29.12.2022.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }

    @IBAction func RegisterButton(_ sender: UIButton) {
//        navigationController?.pushViewController(CategoryViewController(), animated: true)
        self.performSegue(withIdentifier: "nextView", sender: self)
    }
    
}
