//
//  SingleRatingViewController.swift
//  Access.io
//
//  Created by Snehal Mulchandani on 4/19/20.
//  Copyright © 2020 Snehal Mulchandani. All rights reserved.
//

import Foundation
import UIKit
class SingleRatingViewController: UIViewController{

    var currRating:Rating? = nil//pass in
    
    
    @IBOutlet weak var ratingUsername: UILabel!
    
    @IBOutlet weak var ratingLocation: UILabel!
    
    @IBOutlet weak var ratingBody: UILabel!
   
    @IBOutlet weak var ratingTtile: UILabel!
    
    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star5: UIImageView!
    
    @IBOutlet weak var rampRatingstar1: UIImageView!
    @IBOutlet weak var rampRatingstar2: UIImageView!
    @IBOutlet weak var rampRatingstar3: UIImageView!
    @IBOutlet weak var rampRatingstar4: UIImageView!
    @IBOutlet weak var rampRatingstar5: UIImageView!
    
    
    @IBOutlet weak var doorRatingstar1: UIImageView!
    @IBOutlet weak var doorRatingstar2: UIImageView!
    @IBOutlet weak var doorRatingstar3: UIImageView!
    @IBOutlet weak var doorRatingstar4: UIImageView!
    @IBOutlet weak var doorRatingstar5: UIImageView!
    
    @IBOutlet weak var elevatorRatingstar1: UIImageView!
    @IBOutlet weak var elevatorRatingstar2: UIImageView!
    @IBOutlet weak var elevatorRatingstar3: UIImageView!
    @IBOutlet weak var elevatorRatingstar4: UIImageView!
    @IBOutlet weak var elevatorRatingstar5: UIImageView!
    
    
    override func viewDidLoad() {
    super.viewDidLoad()
        let overallStarArray = [star1, star2, star3, star4, star5]
        let rampStarArray = [rampRatingstar1, rampRatingstar2, rampRatingstar3, rampRatingstar4, rampRatingstar5]
        let doorStarArray = [doorRatingstar1, doorRatingstar2, doorRatingstar3, doorRatingstar4, doorRatingstar5]
        let elevatorStarArray = [elevatorRatingstar1, elevatorRatingstar2, elevatorRatingstar3, elevatorRatingstar4, elevatorRatingstar5]



        ratingUsername.text = currRating?.username
        ratingLocation.text = currRating?.locationName
        ratingTtile.text = currRating?.title
        let overallStars: Int = currRating?.rating ?? 0
        let rampRatingStar: Int = currRating?.rampRating ?? 0
        let doorRatingStar: Int = currRating?.doorRating ?? 0
        let elevatorRatingStar: Int = currRating?.elevatorRating ?? 0
        fillStars(rating: overallStars, starArray: overallStarArray)
        fillStars(rating: rampRatingStar, starArray: rampStarArray)
        fillStars(rating: doorRatingStar, starArray: doorStarArray)
        fillStars(rating: elevatorRatingStar, starArray: elevatorStarArray)
       // star1.image = UIImage(named: "star")
        ratingBody.text = currRating?.body
        
    }
    
    func fillStars(rating: Int, starArray: [UIImageView?]){
        var i: Int = 0
        while(i < rating){ //Overall rating
            starArray[i]!.image = UIImage(systemName: "star.fill")
            i+=1
        }
    }
    
}
