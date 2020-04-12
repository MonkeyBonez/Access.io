//
//  ServerClass.swift
//  Access.io
//
//  Created by Snehal Mulchandani on 4/12/20.
//  Copyright © 2020 Snehal Mulchandani. All rights reserved.
//

import Foundation

class server{
    
    var socketConnection:  URLSessionWebSocketTask?
    
    func connectToSocket() {
         let url = URL(string: "ws://localhost:6789/")! //CHANGE TO CORRECT IP & PORT OF SERVER
         socketConnection = URLSession.shared.webSocketTask(with: url)
         socketConnection?.resume()
       }
    
    func sendUser(message: user){
        do{
            let encoder = JSONEncoder()
            let data = try encoder.encode(message)
            let JSONMessage = URLSessionWebSocketTask.Message.data(data)
            print((String(data: data, encoding: .utf8)!))
            socketConnection?.send(JSONMessage) { error in
            if let error = error {
              // handle the error
              print(error)
            }
          }
        }
        catch {
          // handle the error
          print(error)
        }
    }
}
