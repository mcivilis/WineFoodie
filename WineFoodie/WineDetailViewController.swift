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
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
            //loadStoreLocations()
            initialLocationSet = true
        }
    }
    
//MARK: MK Map View Delegate
    
    
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

}
