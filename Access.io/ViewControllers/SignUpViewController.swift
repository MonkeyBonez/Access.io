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

    var connectionToServer:server = server()
    
    @IBOutlet var emailTextBox: UIView!
    @IBOutlet weak var usernameTextBox: UITextField!
    @IBOutlet weak var passwordTextBox: UITextField!
    @IBOutlet weak var emailInUse: UILabel!
    @IBOutlet weak var usernameInUse: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        emailInUse.isHidden = true
        usernameInUse.isHidden = true
        //connectToSocket()
       
        
       
    }
    
    
}
