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
class MapViewController: UIViewController ,MKMapViewDelegate, CLLocationManagerDelegate, UISearchBarDelegate{
    @IBOutlet weak var map: MKMapView!
    var connectionToServer:server = server()
    var currUser:user = user(username: "", password: "")
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
        
        // MARK: - Activity Indicator
        
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
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder()
            dismiss(animated: true, completion: nil)
            
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
                pointAnnotation.title = searchBar.text
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

    }



