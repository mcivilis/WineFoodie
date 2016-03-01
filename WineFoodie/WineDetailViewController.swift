//
//  WineDetailViewController.swift
//  WineFoodie
//
//  Created by Maria Civilis on 2016-02-29.
//  Copyright © 2016 mcivilis. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class WineDetailViewController : UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var originLabel: UILabel!
    @IBOutlet var varietalLabel: UILabel!
    @IBOutlet var styleLabel: UILabel!
    @IBOutlet var wineTypeLabel: UILabel!
    @IBOutlet var sugarContentLabel: UILabel!
    @IBOutlet var sugarInGramsLabel: UILabel!
    @IBOutlet var producerNameLabel: UILabel!
    @IBOutlet var matchRatingLabel: UILabel!
    @IBOutlet var storeLabel: UILabel!
    @IBOutlet var inventoryCountLabel: UILabel!
    
    var currentWine: LCBOWine!
    var initialLocationSet = false
    var locationManager = CLLocationManager()
    var postalCode : String!
    var storeLocations: [LCBOStore]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    downloadWineImage(currentWine.imageURL)
    configureLocation()
    
    }
    
//MARK: CLLocation Manager Delegate
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if (status == CLAuthorizationStatus.AuthorizedWhenInUse) {
            self.locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if (initialLocationSet == false) {
            let userLocation = locationManager.location
            let userRegion = MKCoordinateRegionMake((userLocation?.coordinate)!, MKCoordinateSpanMake(0.1, 0.1))
            mapView.setRegion(userRegion, animated: true)
            getPostalCodeForLocation(userLocation!)
            loadNearbyStores(userLocation!)
            initialLocationSet = true
        }
    }
    
//MARK: MK Map View Delegate
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if (annotation.isEqual(mapView.userLocation)) {
            return nil;
        }
        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier("Stores")
        
        if (pinView == nil) {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "Stores")
        }
        pinView?.image = UIImage(named: "iconLCBO-Open")
        
     return pinView
    }
    
//MARK: Configure location
    
    func configureLocation() {
    mapView.delegate = self;
    locationManager.delegate = self;
        if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.NotDetermined) {
            locationManager.requestWhenInUseAuthorization()
        }
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = 100;
    }

//MARK: Helpers

    func getPostalCodeForLocation(location: CLLocation) {

        CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error)->Void in
            if (error != nil) {
                print(error)
                return
            } else {
                let placemark = placemarks![0] as CLPlacemark
                self.postalCode = placemark.postalCode
                print(self.postalCode)
            }
        })
    }
    
    func downloadWineImage(urlString: String) {
        let url = NSURL(string: urlString)
        let urlRequest = NSURLRequest(URL: url!)
        let dataTask = NSURLSession.sharedSession().dataTaskWithRequest(urlRequest) { (data, response, error) -> Void in
            if error == nil {
                if let imageData = data {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.imageView.image = UIImage(data: imageData)
                    })
                }
            }
        }
        dataTask.resume()
    }
    
    func loadNearbyStores(userLocation:CLLocation) {
        
        let lat = Double(userLocation.coordinate.latitude)
        let lon = Double(userLocation.coordinate.longitude)
        DataManager().storeLocations(lat, longitude: lon, productID: currentWine.code, completion: { (lcboStoreList) -> Void in
            self.storeLocations = lcboStoreList
            for store in lcboStoreList {
                let marker = MKPointAnnotation()
                marker.coordinate = CLLocationCoordinate2DMake(store.latitude, store.longitude)
                marker.title = store.name
                marker.subtitle = "Current inventory: " + store.quantity.description
                self.mapView.addAnnotation(marker)
            }
        })
    }


}
