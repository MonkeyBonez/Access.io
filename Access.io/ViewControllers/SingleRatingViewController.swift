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
    @IBOutlet weak var ratingStars: UILabel!
    override func viewDidLoad() {
    super.viewDidLoad()
        ratingUsername.text = currRating?.username
        ratingLocation.text = currRating?.locationName
        var stars: Int = currRating?.rating ?? 0
        ratingStars.text = String(stars) + "/5"
        ratingBody.text = currRating?.body
    }
    
}
