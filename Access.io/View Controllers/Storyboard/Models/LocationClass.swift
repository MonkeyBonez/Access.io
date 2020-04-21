//
//  LocationClass.swift
//  Access.io
//
//  Created by Snehal Mulchandani on 4/14/20.
//  Copyright © 2020 Snehal Mulchandani. All rights reserved.
//
import UIKit

import Foundation
@objc class Location: NSObject{
    var id:Int
    var name:String
    @objc dynamic var ratings:[Rating]
    var lat:Double
    var long:Double

    init(name:String, lat:Double, long:Double){
        self.name = name
        self.lat = lat
        self.long = long
        id = -1
        //load id & ratings from backend by passing in name
        ratings = [Rating]()
    }
    init(name:String){
           self.name = name
        self.lat = 0
         self.long = 0
         id = -1
         //load id & ratings from backend by passing in name
         ratings = [Rating]()
    }
    /*func addRating(name: String) {
        let r = Rating(userId: -1, title: "DefaultTitle", locationId: -1, ratingString: "", ratingStars: 3, locationName: name)
        ratings.append(r)
    }*/
    /*func addRating(stars: Int, title: String, userID: Int, body:String){
        let r = Rating (userId: userID, title: title, locationId: -1, ratingString: body, ratingStars: stars, locationName: self.name, userName:"DummyUserName")
        ratings.append(r)
        //set locationId from backend
    }*/
    func addReview(reviewAdd: Rating){
        ratings.append(reviewAdd)
    }
    func averageRating() -> Double{
        var numReviews:Int = ratings.count
        if(numReviews == 0){
            return -1
        }
        var totalReviewCount:Int = 0
        for rating in ratings{
            totalReviewCount += rating.rating
        }
        return Double(totalReviewCount)/Double(numReviews)
    }
}
