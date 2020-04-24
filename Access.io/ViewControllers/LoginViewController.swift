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
    @IBOutlet weak var IncorrectLoginText: UILabel!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
   
    var usernameChanged: Bool = false
    var passwordChanged: Bool = false
    var attemptedOnce: Bool = false
    func enableLoginButton(){
        loginButton.isEnabled = true
        loginButton.isOpaque = false
    }
    func disableLoginButton(){
        loginButton.isEnabled = false
        loginButton.isOpaque = true
    }
    
    
        
        func query(address: String) -> String {
            print("ADDRESS FROM QUERY: " + address)
            let url = URL(string: address)
            let semaphore = DispatchSemaphore(value: 0)

            var result: String = ""
            
            let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
                print("before result: " + result)

                result = String(data: data!, encoding: String.Encoding.utf8)!
                print("result 1: " + result)

                semaphore.signal()
            }
            
            task.resume()
            semaphore.wait()
    //        print("result: " + result)
            let trimmedResult = result.trimmingCharacters(in: .whitespacesAndNewlines)
            return trimmedResult
        }
        

    @IBAction func usernameTextChanged(_ sender: Any) {
        usernameChanged = true
        if((usernameTextField.text ?? "").isEmpty){
            usernameChanged = false
            disableLoginButton()
        }
        else if(passwordChanged == true || attemptedOnce == true){
           if(!(passwordTextField.text ?? "").isEmpty && !(usernameTextField.text ?? "").isEmpty){
                enableLoginButton()
            }
        }
    }
    
    @IBAction func passwordTextChanged(_ sender: Any) {
        passwordChanged = true
        if((passwordTextField.text ?? "").isEmpty){
            passwordChanged = false
            disableLoginButton()
        }
        else if(usernameChanged == true || attemptedOnce == true){
            if(!(passwordTextField.text ?? "").isEmpty && !(usernameTextField.text ?? "").isEmpty){
                enableLoginButton()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        IncorrectLoginText.isHidden = true
        disableLoginButton()
        //connectToSocket()
        
       
        
       
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
         IncorrectLoginText.isHidden = true
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
        attemptedOnce = true
        usernameChanged = false
        passwordChanged = false
        disableLoginButton()
//        var sentUser = User(username: username,password: password)
       
        // After checking for errors in the text fields
        // Use sample URL
        // localhost:8080/CSCI201_Group_6/LoginServ?requestType=login&userName=xxx&password=xxx

        let url = "http://localhost:8080/CSCI201_Group_6/LoginServ?requestType=login&userName=" + usernameTextField.text! + "&password=" + passwordTextField.text!
        print(url)
        // Query the login
        let response = query(address: url)
        print("USERID from login: " + response)
        var userId: Int = Int()
        //Get the userID from the back end
        userId = Int(response)!
        
        //If the userID is valid then create a new user
        if(userId >= 0){
            var newUser:User = User(username: username, password: password)
            newUser.setId(id: userId)
            let vc = storyboard?.instantiateViewController(withIdentifier: "MapScreen") as! MapViewController
            //vc.connectionToServer = connectionToServer
            //vc.userId = userId
            vc.currUser = newUser
            navigationController?.pushViewController(vc, animated: true)
        }
        else{
            IncorrectLoginText.isHidden = false
        }
    }
    

}
