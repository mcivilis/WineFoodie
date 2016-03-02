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
    @IBOutlet var mapActivityIndicator: UIActivityIndicatorView!
    
    var currentWine: LCBOWine!
    var initialLocationSet = false
    var locationManager = CLLocationManager()
    var postalCode : String!
    var storeLocations: [LCBOStore]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLocation()
        configureLabels()
        downloadWineImage(currentWine.imageURL)
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
            pinView = MKAnnotationView(annotation: annotation, reuseIdentifier: "Stores")
        }
        pinView?.image = UIImage(named: "iconLCBO")
        
     return pinView
    }

    //MARK: Segue
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "storeList" {
            
            let navController = segue.destinationViewController as! UINavigationController
            let storeListViewController = navController.topViewController as! StoreListViewController
            //storeListViewController.modalPresentationStyle = .Custom
            //storeListViewController.modalTransitionStyle = .FlipHorizontal
            storeListViewController.storeLocations = storeLocations
        }
    }
    


}
