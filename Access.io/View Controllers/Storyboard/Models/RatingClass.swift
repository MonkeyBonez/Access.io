//
//  RatingClass.swift
//  Access.io
//
//  Created by Snehal Mulchandani on 4/14/20.
//  Copyright © 2020 Snehal Mulchandani. All rights reserved.
//

import UIKit
import Foundation
class Rating{
    var username:String
    var userId:Int
    var locationName:String
    var ratingId:Int
    var ratingComment:String//users comment
    var ratingStars:Int
    
    init(userId:Int, locationId:Int, ratingString:String, ratingStars:Int, locationName:String){
        self.userId = userId
        self.ratingComment = ratingString
        self.ratingStars = ratingStars
        self.locationName = locationName
        //load everything below this line from backend
        username = ""
        ratingId = -1
        
    }
    
    func sendRating(){
        //sends rating and location to backend when user creates rating
    }
    
    
}
