//
//  WineDetailViewController+Setup.swift
//  WineFoodie
//
//  Created by Maria Civilis on 2016-03-01.
//  Copyright © 2016 mcivilis. All rights reserved.
//

import Foundation
import MapKit

extension WineDetailViewController {
    
    func configureLocation() {
        mapView.delegate = self;
        locationManager.delegate = self;
        if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.NotDetermined) {
            locationManager.requestWhenInUseAuthorization()
        }
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.distanceFilter = 100;
    }
    
}
