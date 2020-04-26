//
//  RatingClass.swift
//  Access.io
//
//  Created by Snehal Mulchandani on 4/14/20.
//  Copyright © 2020 Snehal Mulchandani. All rights reserved.
//

import UIKit
import Foundation
class Rating: NSObject{
    var username:String
    var userId:Int
    var locationName:String
    var ratingId:Int
    var body:String//users comment
    var otherRating:Int
    var rampRating: Int
    var doorRating: Int
    var elevatorRating: Int
    var title:String
    var upvotes:Int
    var downvotes:Int
   
    
    init(ratingUser: User, title:String, loc: Location, ratingString:String, ratingStars:Int, rampRating: Int, doorRating: Int, elevatorRating:Int){
        self.userId = ratingUser.id
        self.body = ratingString
        self.otherRating = ratingStars
        self.locationName = loc.name
        self.title = title
        self.username = ratingUser.username
        upvotes = 0
        downvotes = 0
        self.rampRating = rampRating
        self.doorRating = doorRating
        self.elevatorRating = elevatorRating
        //load everything below this line from backend
        
        ratingId = -1
        
    }
}
