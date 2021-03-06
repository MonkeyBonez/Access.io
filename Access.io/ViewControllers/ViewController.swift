//
//  ViewController.swift
//  Access.io
//
//  Created by Snehal Mulchandani on 4/11/20.
//  Copyright © 2020 Snehal Mulchandani. All rights reserved.
//

import UIKit


class MainMenuViewController: UIViewController{
    
   
    var myView: MainMenuViewController!
    var connectionToServer:server = server()
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var connectionToServer = server()
        connectionToServer.connectToSocket()
        connectionToServer.sendString(messageString: "Helloworld")
       // myView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginButtonClicked(_ sender: Any) {
        print("Login clicked")
        
     let storyboard = UIStoryboard(name: "Main", bundle: nil)
       
        let vc = storyboard.instantiateViewController(withIdentifier: "LoginScreen") as! LoginViewController
        vc.connectionToServer = connectionToServer
        navigationController?.pushViewController(vc, animated: true)
       
           
        
    }
    @IBAction func signupButtonClicked(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
         let vc = storyboard.instantiateViewController(withIdentifier: "SignupScreen") as! SignUpViewController
         vc.connectionToServer = connectionToServer
         navigationController?.pushViewController(vc, animated: true)
    }
}




