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
    override func viewDidLoad() {
    super.viewDidLoad()
        let starArray = [star1, star2, star3, star4, star5]
        ratingUsername.text = currRating?.username
        ratingLocation.text = currRating?.locationName
        ratingTtile.text = currRating?.title
        var stars: Int = currRating?.rating ?? 0
        var i: Int = 0
        while(i < stars){
            starArray[i]?.image = UIImage(systemName: "star.fill")
            i+=1
        }
       // star1.image = UIImage(named: "star")
        ratingBody.text = currRating?.body
        
    }
    
}
