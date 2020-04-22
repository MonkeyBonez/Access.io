//
//  SignUpViewController.swift
//  Access.io
//
//  Created by Snehal Mulchandani on 4/12/20.
//  Copyright © 2020 Snehal Mulchandani. All rights reserved.
//

import UIKit
import Foundation
class SignUpViewController: UIViewController {

   
    
 
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var emailTextBox: UITextField!
    @IBOutlet weak var usernameTextBox: UITextField!
    @IBOutlet weak var passwordTextBox: UITextField!
    override func viewDidLoad() {
        errorLabel.text = ""
        super.viewDidLoad()
        //connect to server
    }
    @IBAction func signUpButtonPressed(_ sender: Any) {
        errorLabel.text = ""
        var email: String = emailTextBox.text ?? ""
        if(email == "Email"){
            email = ""
        }
        var username: String = usernameTextBox.text ?? ""
        if(username == "Username"){
            username = ""
        }
        var password: String = passwordTextBox.text ?? ""
        if(password == "Password"){
            password = ""
        }
        var userId: Int = 0
        if(email.isEmpty || username.isEmpty || password.isEmpty){
            errorLabel.text = "Fields cannot be left blank"
            if(email.isEmpty){
                emailTextBox.text = "Email"
            }
            if(username.isEmpty){
                usernameTextBox.text = "Username"
            }
            if(password.isEmpty){
                passwordTextBox.text = "Password"
            }
        }
        else if(!isValidEmail(email)){
            errorLabel.text = "Invalid email"
        }
        //send to server & check if username and email already used
        else{
            //backend checks
            var userId: Int = 0
            //random checks - delete later -----
            if(username == "snehalmu"){
                userId = -2
            }
            else if(email == "snehalmu@usc.edu" ){
                userId = -1
            }
            // -------
            if (userId == -1){
                errorLabel.text = "Email already used"
            }
            else if(userId == -2){
                errorLabel.text = "Username already used"
            }
            else if (userId >= 0){
                var newUser:User = User(username: username, password: password)
                newUser.setId(id: userId)
                let vc = storyboard?.instantiateViewController(withIdentifier: "MapScreen") as! MapViewController
              //  vc.connectionToServer = connectionToServer
                vc.userId = userId
                print(userId)
                vc.currUser = newUser
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
}
