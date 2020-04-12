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
    
    func enableLoginButton(){
        
    }
    func disableLoginButton(){
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ViewDidLoad at Login Screen")
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        var username:String = usernameTextField.text ?? ""
        var password:String = passwordTextField.text ?? ""
        if(password == "Password"){
            password = ""
        }
        if(username == "Username"){
            username = ""
        }
        if ((username ?? "").isEmpty || (password ?? "").isEmpty){
            print("empty")
        }
        else{
            print(username + " " + password)
            print("non-empty")
        }
        /*print(usernameTextField.text ?? "")
        print(passwordTextField.text ?? "")*/
    }
    

}
