//
//  MapViewController.swift
//  Access.io
//
//  Created by Snehal Mulchandani on 4/12/20.
//  Copyright © 2020 Snehal Mulchandani. All rights reserved.
//

import UIKit
import Foundation
import MapKit
class MapViewController: UIViewController {
    @IBOutlet weak var map: MKMapView!
    var connectionToServer:server = server()
    var currUser:user = user(username: "", password: "")
    //or can just pass in id
    override func viewDidLoad() {
    super.viewDidLoad()
        map.showsUserLocation = true;
    }
}
