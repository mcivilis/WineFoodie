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
    //@IBOutlet var storeLabel: UILabel!
    //@IBOutlet var inventoryCountLabel: UILabel!
    //@IBOutlet var mapActivityIndicator: UIActivityIndicatorView!
    
    var currentWine: LCBOWine!
    var initialLocationSet = false
    var locationManager = CLLocationManager()
    var postalCode : String!
    var storeLocations: [LCBOStore]!
    var img: UIImageView!
    var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView = UIScrollView(frame: self.imageView.frame)
        scrollView.delegate = self
        let scrollViewFrame = scrollView.frame
        let scaleWidth = scrollViewFrame.size.width / scrollView.contentSize.width
        let scaleHeight = scrollViewFrame.size.height / scrollView.contentSize.height
        let minScale = min(scaleWidth, scaleHeight);
        scrollView.minimumZoomScale = minScale;
        
        scrollView.maximumZoomScale = 1.0
        scrollView.zoomScale = minScale;
    
        
        
        
        
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
            let userRegion = MKCoordinateRegionMake((userLocation?.coordinate)!, MKCoordinateSpanMake(0.04, 0.04))
            mapView.setRegion(userRegion, animated: true)
            getPostalCodeForLocation(userLocation!)
            loadNearbyStores(userLocation!)
            initialLocationSet = true
        }
    }
    
//MARK: MK Map View Delegate
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        print("selected")
        view.annotation?.coordinate
    }
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let identifyer = "Stores"
        if (annotation.isEqual(mapView.userLocation)) {
            return nil;
        }
        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifyer)
        if (pinView == nil) {
            pinView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifyer)
        }
        pinView?.canShowCallout = true
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        btn.setBackgroundImage(UIImage(named: "mapIcon"), forState: .Normal)
        btn.tintColor = kWineFoodieBurgundy
        pinView!.rightCalloutAccessoryView = btn
        pinView?.image = UIImage(named: "iconLCBO")
        
     return pinView
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let coordinate = view.annotation?.coordinate
        let placemark = MKPlacemark(coordinate: coordinate!, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = (view.annotation?.title)!
        MKMapItem.openMapsWithItems([mapItem], launchOptions: nil)
    }


    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.img
    }
    
    @IBAction func tapActionZoomImage(sender: UITapGestureRecognizer) {
        
        img = UIImageView(image: imageView.image)
        img.frame = self.imageView.bounds
        scrollView.addSubview(img)
        img.contentMode = .ScaleAspectFit
        img.clipsToBounds = true
        view.addSubview(scrollView)
        view.bringSubviewToFront(scrollView)
        scrollView.backgroundColor = .whiteColor()
        scrollView.userInteractionEnabled = true
        
        UIView.animateWithDuration(0.3) { () -> Void in
            self.scrollView.frame = self.view.frame
            self.img.frame = self.view.frame
        }
        
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:Selector("imageTapped"))
        img.userInteractionEnabled = true
        img.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func imageTapped() {
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.scrollView.frame = self.imageView.frame
            self.img.frame = self.imageView.bounds
            }) { (Bool) -> Void in
                self.imageView.image = self.img.image
                self.view.bringSubviewToFront(self.imageView)
        }
    }

    
//
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        
//        if segue.identifier == "storeList" {
//            
//            let navController = segue.destinationViewController as! UINavigationController
//            let storeListViewController = navController.topViewController as! StoreListViewController
//            //storeListViewController.modalPresentationStyle = .Custom
//            //storeListViewController.modalTransitionStyle = .FlipHorizontal
//            storeListViewController.storeLocations = storeLocations
//        }
//    }
    


}
