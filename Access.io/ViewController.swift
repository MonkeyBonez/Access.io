//
//  ViewController.swift
//  Access.io
//
//  Created by Snehal Mulchandani on 4/11/20.
//  Copyright © 2020 Snehal Mulchandani. All rights reserved.
//

import UIKit
protocol MyDelegate: class {
     func onButtonTapped()
}

class MainMenuViewController: UIViewController, MyDelegate {
    
      weak var delegate: MyDelegate?
    var myView: MainMenuViewController!
    func onButtonTapped() {
        let nextViewController = LoginViewController()
               navigationController?.pushViewController(nextViewController,
                    animated: false)
               
    }
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // myView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginButtonClicked(_ sender: Any) {
        print("Login clicked")
        
     let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LoginScreen") as! LoginViewController
       
         navigationController?.pushViewController(vc,
         animated: true)
        // self.delegate?.onButtonTapped()
        
        
        /*let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "LoginScreen") as! LoginViewController
        self.navigationController?.pushViewController(newViewController, animated: false)*/
            
        
    }
}




