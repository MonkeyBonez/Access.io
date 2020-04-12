//
//  UserClass.swift
//  Access.io
//
//  Created by Snehal Mulchandani on 4/12/20.
//  Copyright © 2020 Snehal Mulchandani. All rights reserved.
//
import UIKit
import Foundation
class user{
    var username:String
    var password:String
    var id:Int
    
    init(username:String, password:String){
        self.username = username
        self.password = password
        self.id = -1
    }
    
    func deletePassword() {
        self.password = ""
    }
    
    func setId(id:Int){
        self.id = id
    }
    
}
