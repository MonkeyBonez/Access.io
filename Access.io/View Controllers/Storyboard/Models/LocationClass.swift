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

    init(name:String){
        self.name = name
       ratingIDs = [Int]()
        id = -1
        //load id from backend by passing in name
    }
    
}
