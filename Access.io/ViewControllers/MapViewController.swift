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

class MapViewController: UIViewController ,MKMapViewDelegate, CLLocationManagerDelegate, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate, ReviewDelegate {
    
    var ratingLabelArray: [UILabel] = []
    
    var overallStarArray: [UIImageView] = []
    var entranceStarArray: [UIImageView] = []
    var rampStarArray: [UIImageView] = []
    var elevatorStarArray: [UIImageView] = []
    var allStarArray: [UIImageView] = []
    
    @IBOutlet weak var overallStar1: UIImageView!
    @IBOutlet weak var overallStar2: UIImageView!
    @IBOutlet weak var overallStar3: UIImageView!
    @IBOutlet weak var overallStar4: UIImageView!
    @IBOutlet weak var overallStar5: UIImageView!
    
    @IBOutlet weak var entranceStar1: UIImageView!
    @IBOutlet weak var entranceStar2: UIImageView!
    @IBOutlet weak var entranceStar3: UIImageView!
    @IBOutlet weak var entranceStar4: UIImageView!
    @IBOutlet weak var entranceStar5: UIImageView!
    
    @IBOutlet weak var rampStar1: UIImageView!
    @IBOutlet weak var rampStar2: UIImageView!
    @IBOutlet weak var rampStar3: UIImageView!
    @IBOutlet weak var rampStar4: UIImageView!
    @IBOutlet weak var rampStar5: UIImageView!
    
    @IBOutlet weak var elevatorStar1: UIImageView!
    @IBOutlet weak var elevatorStar2: UIImageView!
    @IBOutlet weak var elevatorStar3: UIImageView!
    @IBOutlet weak var elevatorStar4: UIImageView!
    @IBOutlet weak var elevatorStar5: UIImageView!
    
    @IBOutlet weak var map: MKMapView!
    
    @IBOutlet weak var logoutButton: UIButton!
    //var userId:Int = Int()
    var currUser:User = User(username: "", password: "")
    var loc = Location(name: "", lat: 0, long: 0)
    var validLoc:Bool = false
    @IBOutlet weak var addReview: UIButton!
    @IBOutlet var reviewTable: UITableView! {
        didSet {
            reviewTable.dataSource = self
        }
    }

    @IBOutlet weak var ratingLabel: UILabel!
  
    @IBOutlet weak var averageRatingLabel: UILabel!
    
    @IBOutlet weak var entranceRatingLabel: UILabel!
    
    @IBOutlet weak var rampRatingLabel: UILabel!
    
    @IBOutlet weak var elevatorRatingLabel: UILabel!
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
        
    @IBOutlet weak var reviewsLabel: UILabel!
    // MARK: - eActivity Indicator
        
        fileprivate var activityIndicator: UIActivityIndicatorView!
    
        // MARK: - Data Changed
    @objc func dataChanged() {
        print("received data changed")
        updateUI()
    }
        
        
        // MARK: - UIViewController's methods
        static let dataChangedName = Notification.Name("dataChanged")
        override func viewDidLoad() {
            super.viewDidLoad()
            reviewTable.backgroundColor = UIColor(red: 153/255.0, green: 27/255.0, blue: 30/255.0, alpha: 1)
            reviewTable.separatorColor = UIColor(named: "Teal")
           
            
            addReview.isEnabled = false
            overallStarArray = [overallStar1, overallStar2, overallStar3, overallStar4, overallStar5]
            entranceStarArray = [entranceStar1, entranceStar2, entranceStar3, entranceStar4, entranceStar5]
            rampStarArray = [rampStar1, rampStar2, rampStar3, rampStar4, rampStar5]
            elevatorStarArray = [elevatorStar1, elevatorStar2, elevatorStar3, elevatorStar4, elevatorStar5]

            ratingLabelArray = [ratingLabel, entranceRatingLabel, rampRatingLabel, elevatorRatingLabel, reviewsLabel, locationLabel]
            allStarArray = overallStarArray + entranceStarArray + rampStarArray + elevatorStarArray
            
            noRatings()
            if(currUser.id >= 0){
                logoutButton.setTitle("Log out", for: .normal)
            }
            else{
                logoutButton.setTitle("Main menu", for: .normal)
            }
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
            //reviewTable.reloadData()
            zoomToCurrentLocation()
            NotificationCenter.default.addObserver(self, selector: #selector(MapViewController.dataChanged), name: MapViewController.dataChangedName, object: nil)
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            
            activityIndicator.center = self.view.center
            
           /* loc.observe(\Location.ratings, options: .new){location, change in
                print("here")
                self.reviewTable.reloadData()
                    let averageRating:String = String(format: "%.2f", self.loc.averageRating() )
                       
                       if(self.loc.averageRating() > 0.0){
                           self.ratingLabel.text =  "Rating (x/5): "
                           self.ratingLabel.text! += " " + averageRating;
                       }
                       else{
                           self.ratingLabel.text =  "No ratings"
                       }
            }*/
        }
    
    func addRating(rating: Rating) {
          loc.addReview(reviewAdd: rating)
        updateUI()
        //SEND TO BACKEND HERE to create review
    }
    
    
    func updateUI(){
        locationLabel.text = "Location name: "
        locationLabel.text! += " " + loc.name;
        
        // MARK: - SUBMIT USING THIS
//        var url : String"http://ec2-174-129-227-59.compute-1.amazonaws.com/CSCI201_Group_6/LocServ?locationName="
//
//        url += loc.name + "&latitude=" + String(format:"%f", loc.lat)
//        url += "&longitude=" + String(format:"%f", loc.long)
        // MARK: - SUBMIT USING THIS

        var url : String = "http://localhost:8080/CSCI201_Group_6/LocServ?locationName="
        
        url += loc.name + "&latitude=" + String(format:"%f", loc.lat)
        url += "&longitude=" + String(format:"%f", loc.long)
        print("URL FROM MAP:" + url)
        let response = self.query(address: url)
        
        print("got this response map: " + response)
        
        if (response == "Location doesn't exist." || response == "") {
            //i dont know
        } else {
            let data = response.data(using: .utf8)
            let jsonLocation: JSONLocation = try! JSONDecoder().decode(JSONLocation.self, from: data!)
            print(jsonLocation.website)
            loc.locationID = jsonLocation.id
            self.loc.otherRating = jsonLocation.otherRating
            self.loc.rampRating = jsonLocation.rampRating
            self.loc.doorRating = jsonLocation.doorRating
            self.loc.elevatorRating = jsonLocation.elevatorRating
            self.loc.clearReviews();

            // init(ratingUser: User, title:String, loc: Location, ratingString:String, ratingStars:Int){
            for i in jsonLocation.reviews {
                var reviewUser = User(username: i.userName, password: "", email: "")
                //NEED TO ADD PARAMTERS FOR SUB RATINGS
                var r = Rating(ratingUser: reviewUser, title: i.title, loc: loc, ratingString: i.body, ratingStars: Int(i.otherRating), rampRating: Int(i.rampRating), doorRating: Int(i.doorRating), elevatorRating: Int(i.elevatorRating))
                loc.addReview(reviewAdd: r)
            }
        }
        self.reviewTable.reloadData()

        let averageRating:String = String(format: "%.2f", self.loc.otherRating)
        
           if(self.loc.otherRating > 0.0){
            //self.ratingLabel.text = String(format: "Rating: %.2f/5", self.loc.otherRating)
            showRatings()
           }
           else{
              noRatings()
           }
    }
        
        // MARK: - Actions
        
        @objc func currentLocationButtonAction(_ sender: UIBarButtonItem) {
           /* if (CLLocationManager.locationServicesEnabled()) {
                if locationManager == nil {
                    locationManager = CLLocationManager()
                }
                locationManager?.requestWhenInUseAuthorization()
                locationManager.delegate = self
                locationManager.desiredAccuracy = kCLLocationAccuracyBest
                locationManager.requestAlwaysAuthorization()
                locationManager.startUpdatingLocation()
                isCurrentLocation = true
            }*/
            zoomToCurrentLocation()
        }
    func zoomToCurrentLocation(){
        if (CLLocationManager.locationServicesEnabled()) {
            //check
            /*locationManager = nil
            if locationManager == nil {*/
                locationManager = CLLocationManager()
            //}
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
        // MARK: - Query
        func query(address: String) -> String {
            let url = URL(string: address)
            let semaphore = DispatchSemaphore(value: 0)

            var result: String = ""
            
            let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
                result = String(data: data!, encoding: String.Encoding.utf8)!
    //            print("result 1: " + result)

                semaphore.signal()
            }
            
            task.resume()
            semaphore.wait()
    //        print("result: " + result)
            let trimmedResult = result.trimmingCharacters(in: .whitespacesAndNewlines)
            return trimmedResult
        }
        
        // MARK: - UISearchBarDelegate

   
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder()
            dismiss(animated: true, completion: nil)
            // Call web server to get rating ids
            var prevLoc = loc
            loc = Location(name: searchBar.text!)
            
            // Call web server to get ratings from rating ids and add ratings to location
           /* loc.ratingIDs = [5, 5, 3, 2]
            var average = 0.0
            for i in loc.ratingIDs {
                average += Double(i)
            }
            average /= Double(loc.ratingIDs.count)*/
            
            //loc.addRating(name: "Really bad for wheelchairs")
            //loc.addRating(stars: 4, title: "cool", userID: userId, body: "Good place")
            //reviewTable.reloadData()
            if self.map.annotations.count != 0 {
                annotation = self.map.annotations[0]
                self.map.removeAnnotation(annotation)
            }
            
            localSearchRequest = MKLocalSearch.Request()
            localSearchRequest.naturalLanguageQuery = searchBar.text
            localSearchRequest.region = map.region
            localSearch = MKLocalSearch(request: localSearchRequest)
            localSearch.start { [weak self] (localSearchResponse, error) -> Void in
                
                if localSearchResponse == nil {
                    self!.addReview.isEnabled = false
                   /* let alert = UIAlertView(title: nil, message: "Place not found", delegate: self, cancelButtonTitle: "Try again")
                    alert.show()*/
                    let alertController = UIAlertController(title: "Location Not Found", message: "Please search for another location", preferredStyle: UIAlertController.Style.alert) //Replace UIAlertControllerStyle.Alert by UIAlertControllerStyle.alert
                    /*let DestructiveAction = UIAlertAction(title: "Destructive", style: UIAlertAction.Style.destructive) {
                        (result : UIAlertAction) -> Void in
                        print("Destructive")
                    }*/

                    // Replace UIAlertActionStyle.Default by UIAlertActionStyle.default
                    let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                        (result : UIAlertAction) -> Void in
                        print("OK")
                    }

                    //alertController.addAction(DestructiveAction)
                    alertController.addAction(okAction)
                    self?.present(alertController, animated: true, completion: nil)
                    self!.validLoc = false
                    self!.loc = prevLoc
                    return
                }
                else{
                    let pointAnnotation = MKPointAnnotation()
                    
                    self?.loc = Location(name: searchBar.text!, lat: localSearchResponse!.boundingRegion.center.latitude, long: localSearchResponse!.boundingRegion.center.longitude)
                    self!.addReview.isEnabled = true
                    

                    //TESTING AVERAGE
                    /*self?.loc.addRating(stars: 3, title: "Great", userID: 1, body: "Pretty cool")
                    self?.loc.addRating(stars: 5, title: "Amazing", userID: 5, body: "it was really cool")*/
                     //-------
                    let temp = searchBar.text!
                    pointAnnotation.title = temp
                    self!.updateUI()
                    
                /*let averageRating:String = String(format: "%.2f", (self?.loc.averageRating())!)
                if(self?.loc.averageRating() ?? 0 > 0.0){
                    self?.ratingLabel.text =  "Rating (x/5): "
                    self?.ratingLabel.text! += " " + averageRating;
                }
                else{
                    self?.ratingLabel.text =  "No ratings"*/
                
                pointAnnotation.coordinate = CLLocationCoordinate2D(latitude: localSearchResponse!.boundingRegion.center.latitude, longitude: localSearchResponse!.boundingRegion.center.longitude)
                
                print(pointAnnotation.coordinate)
                let pinAnnotationView = MKPinAnnotationView(annotation: pointAnnotation, reuseIdentifier: nil)
                self!.map.centerCoordinate = pointAnnotation.coordinate
                self!.map.addAnnotation(pinAnnotationView.annotation!)
                //self?.reviewTable.reloadData()
                    self!.validLoc = true
                
            }
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
        if(!loc.name.isEmpty && validLoc){
            if(currUser.id >= 0){
                print("adding review")
                //FOR TESTING
                /*loc.addRating(stars: 5, title: "amazing", userID: userId, body: "Really good place")
                 loc.addRating(stars: 2, title: "terrible", userID: userId, body: "Really bad place")*/
                
                //-----
                let vc = storyboard?.instantiateViewController(withIdentifier: "addRatingView") as! AddRatingViewController
                vc.loc = loc
                //vc.userId = userId
                vc.currUser = currUser
                vc.delegate = self
                //vc.previousVC = self
                self.present(vc, animated: true, completion: nil)
                print("line after present")
                //reviewTable.reloadData()
                let averageRating:String = String(format: "%.2f", self.loc.otherRating)
                
                if(self.loc.otherRating > 0.0){
                   /* self.ratingLabel.text =  "Rating (x/5): "
                    self.ratingLabel.text! += " " + averageRating;*/
                    showRatings()
                }
                else{
                    //self.ratingLabel.text =  "No ratings"
                    noRatings()
                }
            
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
        let text = String(r.otherRating) + "/5" + " " + r.title // Maybe this should be title instead?
        
        cell.textLabel?.text = text //3.
        
        return cell //4.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("viewDidAppear")
        DispatchQueue.main.async { self.updateUI() }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRating = loc.ratings[indexPath.row]
        //print(selectedRating.title + "  " + String(selectedRating.rating))
        let vc = storyboard?.instantiateViewController(withIdentifier: "singleRatingView") as! SingleRatingViewController
        vc.currRating = selectedRating
        self.present(vc, animated: true, completion: nil)
    }
   
     
    @IBAction func logoutButtonClicked(_ sender: Any) {
         let vc = storyboard?.instantiateViewController(withIdentifier: "mainMenuView") as! MainMenuViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    func noRatings(){
        averageRatingLabel.text = "Search for a location to discover and create accessibility reviews"
        
        for singleRating in ratingLabelArray{
            singleRating.isHidden = true
        }
        for singleStar in allStarArray{
            singleStar.isHidden = true
        }
        
    }
    func showRatings(){
        averageRatingLabel.text = "Average Ratings:"
        for singleRating in ratingLabelArray{
            singleRating.isHidden = false
        }
        for singleStar in allStarArray{
            singleStar.isHidden = false
            singleStar.image = UIImage(systemName: "star")
        }
        
       /*var overallRating = loc.otherRating
        var entranceRating = loc.doorRating
        var rampRating = loc.rampRating
        var elevatorRating = loc.elevatorRating*/
        fillStars(rating: loc.otherRating, starArray: overallStarArray)
        fillStars(rating: loc.doorRating, starArray: entranceStarArray)
        fillStars(rating: loc.rampRating, starArray: rampStarArray)
        fillStars(rating: loc.elevatorRating, starArray: elevatorStarArray)
        
        
        
        
    }
    
    func fillStars (rating:Double, starArray: [UIImageView]){
        var i = rating
        var j = 0
        while(i >= 1){
            starArray[j].image = UIImage(systemName: "star.fill")
            i-=1
            j+=1
        }
        if(i >= 0.75){
            starArray[j].image = UIImage(systemName: "star.fill")
        }
        else if(i >= 0.35){
            starArray[j].image = UIImage(systemName: "star.lefthalf.fill")
        }
    }


}
