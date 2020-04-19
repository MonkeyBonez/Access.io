//
//  LocationClass.swift
//  Access.io
//
//  Created by Snehal Mulchandani on 4/14/20.
//  Copyright © 2020 Snehal Mulchandani. All rights reserved.
//
import UIKit

import Foundation
class location{
    var ratingIDs:[Int] //each location will have an array of ratingIds assocaited with restraunt
    var id:Int
    var name:String
    var ratings:[Rating]

    init(name:String){
        self.name = name
       ratingIDs = [Int]()
        id = -1
        //load id from backend by passing in name
        ratings = [Rating]()
    }
    /*func addRating(name: String) {
        let r = Rating(userId: -1, title: "DefaultTitle", locationId: -1, ratingString: "", ratingStars: 3, locationName: name)
        ratings.append(r)
    }*/
    func addRating(stars: Int, title: String, userID: Int, body:String){
        let r = Rating (userId: userID, title: title, locationId: -1, ratingString: body, ratingStars: stars, locationName: self.name, userName:"DummyUserName")
        ratings.append(r)
        //set locationId from backend
    }
}
