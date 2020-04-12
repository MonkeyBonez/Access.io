//
//  LoginViewController.swift
//  Access.io
//
//  Created by Snehal Mulchandani on 4/11/20.
//  Copyright © 2020 Snehal Mulchandani. All rights reserved.
//
import UIKit
import Foundation
class LoginViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ViewDidLoad at Login Screen")
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        var username = usernameTextField.text
        var password = passwordTextField.text
        
        /*print(usernameTextField.text ?? "")
        print(passwordTextField.text ?? "")*/
    }
    

}
