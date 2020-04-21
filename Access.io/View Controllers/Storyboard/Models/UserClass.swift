//
//  UserClass.swift
//  Access.io
//
//  Created by Snehal Mulchandani on 4/12/20.
//  Copyright © 2020 Snehal Mulchandani. All rights reserved.
//
import UIKit
import Foundation
class User : Codable{
    var username:String
    var password:String
    var id:Int
    var email:String
    
    init(username:String, password:String){
        self.username = username
        self.password = password
        self.id = -1
        self.email = ""
    }
    init(username:String, password:String, email:String){
           self.username = username
           self.password = password
           self.id = -1
           self.email = email
       }
    
    func deletePassword() {
        self.password = ""
    }
    
    func setId(id:Int){
        self.id = id
    }
    
}
