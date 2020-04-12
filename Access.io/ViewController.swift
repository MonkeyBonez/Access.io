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
    
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // myView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginButtonClicked(_ sender: Any) {
        print("Login clicked")
        
     let storyboard = UIStoryboard(name: "Main", bundle: nil)
       
        let vc = storyboard.instantiateViewController(withIdentifier: "LoginScreen") as UIViewController
        
        navigationController?.pushViewController(vc, animated: true)
       //dismiss(animated: true, completion: nil)
           
        
    }
}




