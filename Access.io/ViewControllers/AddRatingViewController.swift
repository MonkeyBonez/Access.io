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
    var loc: Location?
    var starArray: [UIImageView] = []
    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star5: UIImageView!
    
override func viewDidLoad() {
   super.viewDidLoad()
    locationName.text = loc?.name
    starArray = [star1, star2, star3, star4, star5]
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
    
    func starClicked(starNumber:Int){
        var i:Int = 0
        while(i <= 4){
            if(i < (starNumber)){
                starArray[i].image = UIImage(systemName: "star.fill")
            }
            else{
               starArray[i].image = UIImage(systemName: "star")
            }
        }
    }
    
}
