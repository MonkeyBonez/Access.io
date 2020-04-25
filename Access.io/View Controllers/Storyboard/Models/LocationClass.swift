//
//  LocationClass.swift
//  Access.io
//
//  Created by Snehal Mulchandani on 4/14/20.
//  Copyright © 2020 Snehal Mulchandani. All rights reserved.
//
import UIKit

import Foundation
struct JSONReview: Decodable {
    let title: String
    let body: String
    let rampRating: Double
    let doorRating: Double
    let elevatorRating: Double
    let otherRating: Double
    let userName: String
    let upvotes: Int
    let downvotes: Int
    let image: String
    let locationName: String
}

struct JSONLocation: Decodable {
    let id: Int
    let name: String
    let website: String
    let address:String
    let phoneNumber:String
    let rampRating: Double
    let doorRating: Double
    let elevatorRating: Double
    let otherRating: Double
    let reviews: [JSONReview]
}

@objc class Location: NSObject{
    var locationID:Int
    var name:String
    var address:String
    var phoneNumber:String
    var website:String
    var rating: Double
    var lat:Double
    var long:Double
    @objc dynamic var ratings:[Rating]

    init(name:String, lat:Double, long:Double){
        self.name = name
        self.lat = lat
        self.long = long
        self.address = ""
        self.phoneNumber = ""
        self.website = ""
        self.rating = 0.0
        
        locationID = -1
        //load id & ratings from backend by passing in name
        ratings = [Rating]()
    }
    init(name:String){
           self.name = name
        self.lat = 0
         self.long = 0
        self.address = ""
        self.phoneNumber = ""
        self.website = ""
        self.rating = 0.0
         locationID = -1
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
//        var numReviews:Int = ratings.count
//        if(numReviews == 0){
//            return -1
//        }
//        var totalReviewCount:Int = 0
//        for rating in ratings{
//            totalReviewCount += rating.rating
//        }
//        return Double(totalReviewCount)/Double(numReviews)
        return rating
    }
}
