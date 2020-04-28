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
    //var connectionToServer:server = server()
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        //let redColor = UIColor(displayP3Red: 153, green: 27, blue: 30, alpha: 0.5)
       
        navigationController?.navigationBar.barTintColor =  UIColor(red: 153/255.0, green: 27/255.0, blue: 30/255.0, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor(red: 255/255.0, green: 204/255.0, blue: 0.0, alpha: 1.0)]
        navigationController?.navigationBar.tintColor = UIColor(red: 255/255.0, green: 204/255.0, blue: 0.0, alpha: 1.0)
        self.navigationItem.hidesBackButton = true
        super.viewDidLoad()
       // myView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginButtonClicked(_ sender: Any) {
        print("Login clicked")
        
     let storyboard = UIStoryboard(name: "Main", bundle: nil)
       
        let vc = storyboard.instantiateViewController(withIdentifier: "LoginScreen") as! LoginViewController
        //vc.connectionToServer = connectionToServer
        navigationController?.pushViewController(vc, animated: true)
       
           
        
    }
    @IBAction func signupButtonClicked(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
         let vc = storyboard.instantiateViewController(withIdentifier: "SignupScreen") as! SignUpViewController
         //vc.connectionToServer = connectionToServer
         navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func continueAsGuestButtonClicked(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "MapScreen") as! MapViewController
        //vc.connectionToServer = connectionToServer
        var guestUser: User = User(username: "SHOULD NOT BE VISIBLE: Guest", password: "Guest")
        guestUser.setId(id: -1)
        vc.currUser = guestUser
        navigationController?.pushViewController(vc, animated: true)
    }
}




