//
//  AddRatingViewController.swift
//  Access.io
//
//  Created by Snehal Mulchandani on 4/20/20.
//  Copyright © 2020 Snehal Mulchandani. All rights reserved.
//


import Foundation
import UIKit
class AddRatingViewController: UIViewController{

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var locationName: UILabel!
    @IBOutlet weak var bodyTextField: UITextField!
    var userId: Int?
    var loc: location?
override func viewDidLoad() {
   super.viewDidLoad()
    
    }
    @IBAction func titleEditingDidBegin(_ sender: Any) {
        if(titleTextField.text  == "Title"){
            titleTextField.text = ""
        }
    }
    
    @IBAction func bodyEditingDidBegin(_ sender: Any) {
        if(bodyTextField.text  == "Body"){
            bodyTextField.text = ""
        }
    }
    
}
