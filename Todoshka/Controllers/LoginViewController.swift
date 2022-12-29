//
//  LoginViewController.swift
//  Todoshka
//
//  Created by Amir Zhunussov on 29.12.2022.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func logInButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goTo", sender: self)
    }
    

}
