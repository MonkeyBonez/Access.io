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
    var body:String//users comment
    var rating:Int
    var title:String
    var upvotes:Int
    var downvotes:Int
    
    init(userId:Int, title:String, locationId:Int, ratingString:String, ratingStars:Int, locationName:String){
        self.userId = userId
        self.body = ratingString
        self.rating = ratingStars
        self.locationName = locationName
        self.title = title
        upvotes = 0
        downvotes = 0
        //load everything below this line from backend
        username = ""
        ratingId = -1
        
    }
    
   
    func sendRating(){
        //sends rating and location to backend when user creates rating
    }
    
    
}
