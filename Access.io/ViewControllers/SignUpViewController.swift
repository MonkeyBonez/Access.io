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
    
    func query(address: String) -> String {
        let url = URL(string: address)
        let semaphore = DispatchSemaphore(value: 0)

        var result: String = ""
        
        let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
            result = String(data: data!, encoding: String.Encoding.utf8)!
//            print("result 1: " + result)

            semaphore.signal()
        }
        
        task.resume()
        semaphore.wait()
//        print("result: " + result)
        let trimmedResult = result.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmedResult
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
            let url = "http://localhost:8080/CSCI201_Group_6/LoginServ?requestType=register&email=" + emailTextBox.text! + "&name=" + usernameTextBox.text! + "&userName=" + usernameTextBox.text! + "&password=" + passwordTextBox.text!
            let response = query(address: url)
            print("got this response: " + response)
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
            if (response == "This user already exists."){
                errorLabel.text = "User already exists"
            } else {
                let intResponse = Int(response)
                if (intResponse! >= 0){
                               
                    var newUser:User = User(username: usernameTextBox.text!, password: passwordTextBox.text!)
                    newUser.setId(id: intResponse!)
                    let vc = storyboard?.instantiateViewController(withIdentifier: "MapScreen") as! MapViewController
                             //  vc.connectionToServer = connectionToServer
                    //vc.userId = userId
                    //print(userId)
                    vc.currUser = newUser
                    navigationController?.pushViewController(vc, animated: true)
                } else {
                    errorLabel.text = "Could not insert"
                }
            }
           
        }
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
}
