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

      var previousVC:MapViewController? = nil
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var locationName: UILabel!
    @IBOutlet weak var bodyTextField: UITextField!
    var userId: Int?
    var currUser: User?
    var loc: Location?
    var starArray: [UIButton] = []
    var ratingStars: Int = 0
    @IBOutlet weak var errorField: UILabel!
    
    @IBOutlet weak var star1: UIButton!
    @IBOutlet weak var star2: UIButton!
    @IBOutlet weak var star3: UIButton!
    @IBOutlet weak var star4: UIButton!
    @IBOutlet weak var star5: UIButton!
    
    override func viewDidLoad() {
   super.viewDidLoad()
        errorField.text = ""
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
        ratingStars = starNumber
        var i:Int = 0
        while(i <= 4){
            if(i < (starNumber)){
                starArray[i].setImage(UIImage(systemName: "star.fill"), for: .normal)
              //  starArray[i].image = UIImage(systemName: "star.fill")
            }
            else{
               starArray[i].setImage(UIImage(systemName: "star"), for: .normal)
                
            }
            i+=1
        }
        
    }
    
    @IBAction func star1Clicked(_ sender: Any) {
        starClicked(starNumber: 1)
    }
    @IBAction func star2Clicked(_ sender: Any) {
        starClicked(starNumber: 2)
    }
    @IBAction func star3Clicked(_ sender: Any) {
        starClicked(starNumber: 3)
    }
    @IBAction func star4Clicked(_ sender: Any) {
        starClicked(starNumber: 4)
    }
    @IBAction func star5Clicked(_ sender: Any) {
        starClicked(starNumber: 5)
    }
    
    
    @IBAction func postButtonPressed(_ sender: Any) {
        var alreadyReviewed: Bool = false
        for singleRating in loc!.ratings{
            if(Bool(currUser!.id == singleRating.userId)){
                alreadyReviewed = true
            }
        }
        if(alreadyReviewed){
            errorField.text = "Location already reviewed"
        }
        else if(titleTextField.text?.isEmpty ?? false || titleTextField.text == "Title" || ratingStars == 0 || bodyTextField.text?.isEmpty ?? false || bodyTextField.text == "Body"){
            //show error
            errorField.text = "Fill out all fields"
        }// make another else if checking if user already reviewed
        else{
            var newRating:Rating = Rating(ratingUser: currUser!, title: titleTextField.text!, loc: loc!, ratingString: bodyTextField.text!, ratingStars: ratingStars)
            //SEND TO BACKEND HERE to create review
            loc!.addReview(reviewAdd: newRating)
            previousVC?.updateUI()
            navigationController?.popViewController(animated: true)
            dismiss(animated: true, completion: nil)
        }
    }
}
