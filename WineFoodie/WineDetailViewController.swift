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

let kWineFoodieBurgundy = UIColor(red: 125/255, green: 44/255, blue: 95/255, alpha: 1.0)
let kWineFoodieGray = UIColor(red: 127/255, green: 127/255, blue: 127/255, alpha: 1.0)

class WineDetailViewController : UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, UIScrollViewDelegate {
    
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
    
    var currentWine: LCBOWine!
    var initialLocationSet = false
    var locationManager = CLLocationManager()
    var postalCode : String!
    var storeLocations: [LCBOStore]!
    var img: UIImageView!
    var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLocation()
        configureLabels()
        configureScrollView()
        downloadWineImage(currentWine.imageURL)
    }
    
//MARK: CLLocation Manager Delegate
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if (status == CLAuthorizationStatus.authorizedWhenInUse) {
            self.locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if (initialLocationSet == false) {
            let userLocation = locationManager.location
            let userRegion = MKCoordinateRegionMake((userLocation?.coordinate)!, MKCoordinateSpanMake(0.04, 0.04))
            mapView.setRegion(userRegion, animated: true)
            getPostalCodeForLocation(userLocation!)
            loadNearbyStores(userLocation!)
            initialLocationSet = true
        }
    }
    
//MARK: MK Map View Delegate
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        view.annotation?.coordinate
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifyer = "Stores"
        if (annotation.isEqual(mapView.userLocation)) {
            return nil;
        }
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: identifyer)
        if (pinView == nil) {
            pinView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifyer)
        }
        pinView?.canShowCallout = true
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        btn.setBackgroundImage(UIImage(named: "mapIcon"), for: UIControlState())
        btn.tintColor = kWineFoodieBurgundy
        pinView!.rightCalloutAccessoryView = btn
        pinView?.image = UIImage(named: "iconLCBO")
        
     return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let coordinate = view.annotation?.coordinate
        let placemark = MKPlacemark(coordinate: coordinate!, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = (view.annotation?.title)!
        MKMapItem.openMaps(with: [mapItem], launchOptions: nil)
    }


    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.img
    }    


}
