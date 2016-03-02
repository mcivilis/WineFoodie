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
        matchRatingLabel.text = "Food Match = " + formatMatchRanking(currentWine.matchRating)
        
    }
    
    func formatMatchRanking(matchRanking: Float) -> String {
        let percent = Float(roundf(matchRanking))
        let matchString = percent.description + "%"
        return matchString
    }

}
