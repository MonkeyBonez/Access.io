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
import CoreLocation

class MapViewController: UIViewController ,MKMapViewDelegate, CLLocationManagerDelegate, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate{

    

    
    @IBOutlet weak var map: MKMapView!
    var connectionToServer:server = server()
    var userId:Int = Int()
    var currUser:user = user(username: "", password: "")

    @IBOutlet weak var addReview: UIButton!
    @IBOutlet var reviewTable: UITableView! {
        didSet {
            reviewTable.dataSource = self
        }
    }

    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    //or can just pass in id
    /*override func viewDidLoad() {
    super.viewDidLoad()
        
        //CLLocationManager.requestWhenInUseAuthorization(map)
        map.showsUserLocation = true;
    }*/
    fileprivate var searchController: UISearchController!
        fileprivate var localSearchRequest: MKLocalSearch.Request!
        fileprivate var localSearch: MKLocalSearch!
        fileprivate var localSearchResponse: MKLocalSearch.Response!
        
        // MARK: - Map variables
        
        fileprivate var annotation: MKAnnotation!
        fileprivate var locationManager: CLLocationManager!
        fileprivate var isCurrentLocation: Bool = false
        
        // MARK: - eActivity Indicator
        
        fileprivate var activityIndicator: UIActivityIndicatorView!
        
        // MARK: - UIViewController's methods
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            let currentLocationButton = UIBarButtonItem(title: "Current Location", style: UIBarButtonItem.Style.plain, target: self, action: #selector(MapViewController.currentLocationButtonAction(_:)))
            self.navigationItem.leftBarButtonItem = currentLocationButton
            
            let searchButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.search, target: self, action: #selector(MapViewController.searchButtonAction(_:)))
            self.navigationItem.rightBarButtonItem = searchButton
            
            map.delegate = self
            map.mapType = .hybrid
            
            activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
            activityIndicator.hidesWhenStopped = true
            self.view.addSubview(activityIndicator)
            
            reviewTable.dataSource = self
            reviewTable.delegate = self
            reviewTable.reloadData()
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            
            activityIndicator.center = self.view.center
        }
        
        // MARK: - Actions
        
        @objc func currentLocationButtonAction(_ sender: UIBarButtonItem) {
            if (CLLocationManager.locationServicesEnabled()) {
                if locationManager == nil {
                    locationManager = CLLocationManager()
                }
                locationManager?.requestWhenInUseAuthorization()
                locationManager.delegate = self
                locationManager.desiredAccuracy = kCLLocationAccuracyBest
                locationManager.requestAlwaysAuthorization()
                locationManager.startUpdatingLocation()
                isCurrentLocation = true
            }
        }
        
        // MARK: - Search
        
        @objc func searchButtonAction(_ button: UIBarButtonItem) {
            if searchController == nil {
                searchController = UISearchController(searchResultsController: nil)
            }
            searchController.hidesNavigationBarDuringPresentation = false
            self.searchController.searchBar.delegate = self
            present(searchController, animated: true, completion: nil)
        }
        
        // MARK: - UISearchBarDelegate
    var loc = location(name: "")

   
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder()
            dismiss(animated: true, completion: nil)
            // Call web server to get rating ids
            loc = location(name: searchBar.text!)
            locationLabel.text = "Location name: "
            locationLabel.text! += " " + loc.name;
            // Call web server to get ratings from rating ids and add ratings to location
            loc.ratingIDs = [5, 5, 3, 2]
            var average = 0.0
            for i in loc.ratingIDs {
                average += Double(i)
            }
            average /= Double(loc.ratingIDs.count)
            let averageRating:String = String(format:"%1.1f", average)
            
            ratingLabel.text =  "Rating (x/5): "
            ratingLabel.text! += " " + averageRating;
            //loc.addRating(name: "Really bad for wheelchairs")
            loc.addRating(stars: 4, title: "cool", userID: userId, body: "Good place")
            reviewTable.reloadData()
            if self.map.annotations.count != 0 {
                annotation = self.map.annotations[0]
                self.map.removeAnnotation(annotation)
            }
            
            localSearchRequest = MKLocalSearch.Request()
            localSearchRequest.naturalLanguageQuery = searchBar.text
            localSearch = MKLocalSearch(request: localSearchRequest)
            localSearch.start { [weak self] (localSearchResponse, error) -> Void in
                
                if localSearchResponse == nil {
                    let alert = UIAlertView(title: nil, message: "Place not found", delegate: self, cancelButtonTitle: "Try again")
                    alert.show()
                    return
                }
                
                let pointAnnotation = MKPointAnnotation()
                let temp = searchBar.text! + "\n" + "Rating: " + averageRating
                pointAnnotation.title = temp
                pointAnnotation.coordinate = CLLocationCoordinate2D(latitude: localSearchResponse!.boundingRegion.center.latitude, longitude: localSearchResponse!.boundingRegion.center.longitude)
                
                let pinAnnotationView = MKPinAnnotationView(annotation: pointAnnotation, reuseIdentifier: nil)
                self!.map.centerCoordinate = pointAnnotation.coordinate
                self!.map.addAnnotation(pinAnnotationView.annotation!)
            }
        }
        
        // MARK: - CLLocationManagerDelegate
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            
            if !isCurrentLocation {
                return
            }
            
            isCurrentLocation = false
            
            let location = locations.last
            let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            
            self.map.setRegion(region, animated: true)
            
            if self.map.annotations.count != 0 {
                annotation = self.map.annotations[0]
                self.map.removeAnnotation(annotation)
            }
            
            let pointAnnotation = MKPointAnnotation()
            pointAnnotation.coordinate = location!.coordinate
            pointAnnotation.title = ""
            map.addAnnotation(pointAnnotation)
        }

    // MARK: - Add a review
    
    @IBAction func addButtonPressed(_ sender: Any) {
        if(!loc.name.isEmpty){
            if(userId >= 0){
                print("adding review")
                loc.addRating(stars: 5, title: "amazing", userID: userId, body: "Really good place")
                 loc.addRating(stars: 2, title: "terrible", userID: userId, body: "Really bad place")
                reviewTable.reloadData()
            }
            else{
                print("invalid user")
                let vc = storyboard?.instantiateViewController(withIdentifier: "SignupScreen") as! SignUpViewController
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return loc.ratings.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell

        
        let r = loc.ratings[indexPath.row]
        let text = String(r.rating) + "/5" + " " + r.title // Maybe this should be title instead?
        
        cell.textLabel?.text = text //3.
        
        return cell //4.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("viewDidAppear")
        DispatchQueue.main.async { self.reviewTable.reloadData() }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRating = loc.ratings[indexPath.row]
        //print(selectedRating.title + "  " + String(selectedRating.rating))
        let vc = storyboard?.instantiateViewController(withIdentifier: "singleRatingView") as! SingleRatingViewController
        vc.currRating = selectedRating
        self.present(vc, animated: true, completion: nil)
    }
}



