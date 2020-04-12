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
   
    var usernameChanged: Bool = false
    var passwordChanged: Bool = false
   
    func enableLoginButton(){
        loginButton.isEnabled = true
        loginButton.isOpaque = false
    }
    func disableLoginButton(){
        loginButton.isEnabled = false
        loginButton.isOpaque = true
    }
    
   /* @IBAction func usernameEditingBegin(_ sender: Any) {
        if((usernameTextField.text ?? "").isEmpty){
            usernameChanged = false
            disableLoginButton()
        }
    }*/
    @IBAction func usernameTextChanged(_ sender: Any) {
        usernameChanged = true
        if((usernameTextField.text ?? "").isEmpty){
            usernameChanged = false
            disableLoginButton()
        }
        else if(passwordChanged == true){
            enableLoginButton()
        }
    }
    
    @IBAction func passwordTextChanged(_ sender: Any) {
        passwordChanged = true
        if((passwordTextField.text ?? "").isEmpty){
            passwordChanged = false
            disableLoginButton()
        }
        else if(usernameChanged == true){
            enableLoginButton()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ViewDidLoad at Login Screen")
        disableLoginButton()
       
        
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
        usernameChanged = false
        passwordChanged = false
        disableLoginButton()
        var sentUser = user(username: username,password: password)
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try! encoder.encode(sentUser)
        let userJSON = (String(data: data, encoding: .utf8)!)
        
       
        
    }
    

}
