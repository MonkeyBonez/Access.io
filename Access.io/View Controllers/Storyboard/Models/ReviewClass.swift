//
//  ReviewClass.swift
//  Access.io
//
//  Created by Robbie Villarica on 4/18/20.
//  Copyright © 2020 Snehal Mulchandani. All rights reserved.
//

import Foundation

class Review {
    var author: String;
    var userID: Int;
    var date: String;
    var 
    
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
