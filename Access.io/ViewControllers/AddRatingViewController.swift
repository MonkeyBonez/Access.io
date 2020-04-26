//
//  AddRatingViewController.swift
//  Access.io
//
//  Created by Snehal Mulchandani on 4/20/20.
//  Copyright © 2020 Snehal Mulchandani. All rights reserved.
//


import Foundation
import UIKit

protocol ReviewDelegate: class {
    func addRating(rating: Rating)
}
class AddRatingViewController: UIViewController{

      //var previousVC:MapViewController? = nil
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var locationName: UILabel!
    @IBOutlet weak var bodyTextField: UITextField!
    //var userId: Int?
    var currUser: User?
    var loc: Location?
    
    var starArray: [UIButton] = []
    var rampStarArray: [UIButton] = []
    var doorStarArray: [UIButton] = []
    var elevatorStarArray: [UIButton] = []
    
    //var ratingArray: [Int] = []
    var overallRatingStars: Int = 0 //OVERALL/other RAting
    var rampRatingStars: Int = 0
    var doorRatingStars: Int = 0
    var elevatorRatingStars: Int = 0
    weak var delegate: ReviewDelegate?
    @IBOutlet weak var errorField: UILabel!
    
    @IBOutlet weak var star1: UIButton!
    @IBOutlet weak var star2: UIButton!
    @IBOutlet weak var star3: UIButton!
    @IBOutlet weak var star4: UIButton!
    @IBOutlet weak var star5: UIButton!
    

    @IBOutlet weak var rampRatingstar1: UIButton!
    @IBOutlet weak var rampRatingstar2: UIButton!
    @IBOutlet weak var rampRatingstar3: UIButton!
    @IBOutlet weak var rampRatingstar4: UIButton!
    @IBOutlet weak var rampRatingstar5: UIButton!
    
    @IBOutlet weak var doorRatingstar1: UIButton!
    @IBOutlet weak var doorRatingstar2: UIButton!
    @IBOutlet weak var doorRatingstar3: UIButton!
    @IBOutlet weak var doorRatingstar4: UIButton!
    @IBOutlet weak var doorRatingstar5: UIButton!
    
    @IBOutlet weak var elevatorRatingstar1: UIButton!
    @IBOutlet weak var elevatorRatingstar2: UIButton!
    @IBOutlet weak var elevatorRatingstar3: UIButton!
    @IBOutlet weak var elevatorRatingstar4: UIButton!
    @IBOutlet weak var elevatorRatingstar5: UIButton!
    
    
    override func viewDidLoad() {
   super.viewDidLoad()
        errorField.text = ""
    locationName.text = loc?.name
    starArray = [star1, star2, star3, star4, star5]
    rampStarArray = [rampRatingstar1, rampRatingstar2, rampRatingstar3, rampRatingstar4, rampRatingstar5]
    doorStarArray = [doorRatingstar1, doorRatingstar2, doorRatingstar3, doorRatingstar4, doorRatingstar5]
    elevatorStarArray = [elevatorRatingstar1, elevatorRatingstar2, elevatorRatingstar3, elevatorRatingstar4, elevatorRatingstar5]
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
    
    func starClicked(starNumber:Int, starsArray: [UIButton]){
        var i:Int = 0
        while(i <= 4){
            if(i < (starNumber)){
                starsArray[i].setImage(UIImage(systemName: "star.fill"), for: .normal)
              //  starArray[i].image = UIImage(systemName: "star.fill")
            }
            else{
               starsArray[i].setImage(UIImage(systemName: "star"), for: .normal)
                
            }
            i+=1
        }
        
    }
    
    @IBAction func star1Clicked(_ sender: Any) {
        overallRatingStars = 1
        starClicked(starNumber: 1, starsArray: starArray)
    }
    @IBAction func star2Clicked(_ sender: Any) {
        overallRatingStars = 2
        starClicked(starNumber: 2, starsArray: starArray)
    }
    @IBAction func star3Clicked(_ sender: Any) {
        overallRatingStars = 3
        starClicked(starNumber: 3, starsArray: starArray)
    }
    @IBAction func star4Clicked(_ sender: Any) {
        overallRatingStars = 4
        starClicked(starNumber: 4, starsArray: starArray)
    }
    @IBAction func star5Clicked(_ sender: Any) {
        overallRatingStars = 5
        starClicked(starNumber: 5, starsArray: starArray)
    }
    
    @IBAction func ramp1StarClicked(_ sender: Any) {
        rampRatingStars = 1
         starClicked(starNumber: 1, starsArray: rampStarArray)
    }
    @IBAction func ramp2StarClicked(_ sender: Any) {
        rampRatingStars = 2
        starClicked(starNumber: 2, starsArray: rampStarArray)
    }
    @IBAction func ramp3StarClicked(_ sender: Any) {
        rampRatingStars = 3
        starClicked(starNumber: 3, starsArray: rampStarArray)
    }
    @IBAction func ramp4StarClicked(_ sender: Any) {
        rampRatingStars = 4
        starClicked(starNumber: 4, starsArray: rampStarArray)
    }
    @IBAction func ramp5StarClicked(_ sender: Any) {
        rampRatingStars = 5
        starClicked(starNumber: 5, starsArray: rampStarArray)
    }
    
    @IBAction func door1StarClicked(_ sender: Any) {
        doorRatingStars = 1
        starClicked(starNumber: 1, starsArray: doorStarArray)
    }
    @IBAction func door2StarClicked(_ sender: Any) {
        doorRatingStars = 2
        starClicked(starNumber: 2, starsArray: doorStarArray)
    }
    @IBAction func door3StarClicked(_ sender: Any) {
        doorRatingStars = 3
        starClicked(starNumber: 3, starsArray: doorStarArray)
    }
    @IBAction func door4StarClicked(_ sender: Any) {
        doorRatingStars = 4
        starClicked(starNumber: 4, starsArray: doorStarArray)
    }
    @IBAction func door5StarClicked(_ sender: Any) {
        doorRatingStars = 5
        starClicked(starNumber: 5, starsArray: doorStarArray)
    }
    
    @IBAction func elevator1StarClicked(_ sender: Any) {
         elevatorRatingStars = 1
               starClicked(starNumber: 1, starsArray: elevatorStarArray)
    }
    @IBAction func elevator2StarClicked(_ sender: Any) {
        elevatorRatingStars = 2
        starClicked(starNumber: 2, starsArray: elevatorStarArray)
    }
    @IBAction func elevator3StarClicked(_ sender: Any) {
        elevatorRatingStars = 3
        starClicked(starNumber: 3, starsArray: elevatorStarArray)
    }
    @IBAction func elevator4StarClicked(_ sender: Any) {
        elevatorRatingStars = 4
        starClicked(starNumber: 4, starsArray: elevatorStarArray)
    }
    @IBAction func elevator5StarClicked(_ sender: Any) {
        elevatorRatingStars = 5
        starClicked(starNumber: 5, starsArray: elevatorStarArray)
    }
    
    
    
    
    
    
    
    
    @IBAction func postButtonPressed(_ sender: Any) {
        // useless?
        var alreadyReviewed: Bool = false
        for singleRating in loc!.ratings{
            if(Bool(currUser!.username == singleRating.username)){
                alreadyReviewed = true
                
            }
        }
        // useless?

        if(alreadyReviewed){
            errorField.text = "Location already reviewed"
        }
        else if(titleTextField.text?.isEmpty ?? false || titleTextField.text == "Title" || overallRatingStars == 0 || bodyTextField.text?.isEmpty ?? false || bodyTextField.text == "Body" || elevatorRatingStars == 0 || doorRatingStars == 0 || rampRatingStars == 0){
            //show error
            errorField.text = "Fill out all fields"
        }// make another else if checking if user already reviewed
        else{
            print("LOCATION ID:")
            print(    loc!.locationID)
            var newRating:Rating = Rating(ratingUser: currUser!, title: titleTextField.text!, loc: loc!, ratingString: bodyTextField.text!, ratingStars: overallRatingStars, rampRating: rampRatingStars, doorRating: doorRatingStars, elevatorRating: elevatorRatingStars)
//            delegate?.addRating(rating: newRating)
            
            var url : String = "http://localhost:8080/CSCI201_Group_6/ReviewServ?locationID=" + String(format: "%d", loc?.locationID as! CVarArg)
            url += "&userID=" + String(format: "%d", currUser!.id)
            
            url += "&requestType=submitReview&title=" + titleTextField.text!
            url += "&body=" + bodyTextField.text!
            url += "&otherRating=" + String(format: "%d", overallRatingStars)
            url += "&elevatorRating=0"
            url += "&rampRating=0"
            url += "&doorRating=0"

            print("URL FROM ADD RATING:" + url)
            let response = query(address: url)
            
            print("got this response ADD RATING: " + response)
            
            
//            loc!.addReview(reviewAdd: newRating)
            //previousVC?.updateUI()
            navigationController?.popViewController(animated: true)
            dismiss(animated: true, completion: nil)
        }
    }
}
