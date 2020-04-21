//
//  RatingClass.swift
//  Access.io
//
//  Created by Snehal Mulchandani on 4/14/20.
//  Copyright © 2020 Snehal Mulchandani. All rights reserved.
//

import UIKit
import Foundation
@objc class Rating: NSObject{
    @objc dynamic var username:String
    @objc dynamic var userId:Int
    @objc dynamic var locationName:String
    @objc dynamic var ratingId:Int
    @objc dynamic var body:String//users comment
    @objc dynamic var rating:Int
    @objc dynamic var title:String
    @objc dynamic var upvotes:Int
    @objc dynamic var downvotes:Int
    
    init(ratingUser: User, title:String, loc: Location, ratingString:String, ratingStars:Int){
        self.userId = ratingUser.id
        self.body = ratingString
        self.rating = ratingStars
        self.locationName = loc.name
        self.title = title
        self.username = ratingUser.username
        upvotes = 0
        downvotes = 0
        //load everything below this line from backend
        
        ratingId = -1
        
    }
    
   
    func sendRating(){
        //sends rating and location to backend when user creates rating
    }
    
    
}
