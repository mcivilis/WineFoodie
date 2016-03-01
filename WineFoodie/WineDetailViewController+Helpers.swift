//
//  WineDetailViewController+Helpers.swift
//  WineFoodie
//
//  Created by Maria Civilis on 2016-03-01.
//  Copyright © 2016 mcivilis. All rights reserved.
//

import Foundation
import UIKit
import MapKit

extension WineDetailViewController {
    
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
        view.bringSubviewToFront(mapActivityIndicator)
        mapActivityIndicator.startAnimating()
        let lat = Double(userLocation.coordinate.latitude)
        let lon = Double(userLocation.coordinate.longitude)
        DataManager().storeLocations(lat, longitude: lon, productID: currentWine.code, completion: { (lcboStoreList) -> Void in
            self.storeLocations = lcboStoreList
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.mapActivityIndicator.stopAnimating()
                for store in lcboStoreList {
                    let marker = MKPointAnnotation()
                    marker.coordinate = CLLocationCoordinate2DMake(store.latitude, store.longitude)
                    marker.title = store.name
                    marker.subtitle = "Current inventory: " + store.quantity.description
                    self.mapView.addAnnotation(marker)
                }
            })
        })
    }
}