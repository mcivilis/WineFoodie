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
    
    func configureLabels() {
        nameLabel.text = currentWine.name
        originLabel.text = currentWine.origin
        varietalLabel.text = currentWine.varietal
        styleLabel.text = currentWine.style
        wineTypeLabel.text = currentWine.secondaryCategory
        sugarContentLabel.text = currentWine.sugarContent
        sugarInGramsLabel.text = currentWine.sugarInGrams.description + " grams sugar / liter"
        producerNameLabel.text = currentWine.producerName
    }
    
    func configureScrollView() {
        scrollView = UIScrollView(frame: self.imageView.frame)
        scrollView.delegate = self
        let scrollViewFrame = scrollView.frame
        let scaleWidth = scrollViewFrame.size.width / scrollView.contentSize.width
        let scaleHeight = scrollViewFrame.size.height / scrollView.contentSize.height
        let minScale = min(scaleWidth, scaleHeight);
        scrollView.minimumZoomScale = minScale;
        scrollView.maximumZoomScale = 1.0
        scrollView.zoomScale = minScale;
    }

}
