//
//  MainViewController.swift
//  WineFoodie
//
//  Created by Maria Civilis on 2016-02-22.
//  Copyright © 2016 mcivilis. All rights reserved.
//

import UIKit
import MapKit

class MainViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, CLLocationManagerDelegate {
    
//MARK: Properties
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var flowLayout: UICollectionViewFlowLayout!
    let locationManager = CLLocationManager()
    let dataManager = DataManager()
    var closestStoreID = 511 //Defaults to King & Spadina store location
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLocation()
    }
    
    func configureLocation() {
        locationManager.delegate = self;
        if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.NotDetermined) {
            locationManager.requestWhenInUseAuthorization()
        }
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.distanceFilter = 100;
    }
    
//MARK: Collection View Data Source
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let foodsInSection = sectionFoods[section]
        return foodsInSection.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! FoodCell
        let foodsInSection = sectionFoods[indexPath.section]
        cell.foodLabel.text = foodsInSection[indexPath.row]
        return cell
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return sectionNames.count
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        var reusableview : UICollectionReusableView!
        if (kind == UICollectionElementKindSectionHeader) {
            let header = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "Header", forIndexPath: indexPath) as! FoodHeader
            header.headerLabel.text = sectionNames[indexPath.section]
            reusableview = header;
        }
        return reusableview
    }
    

// MARK: - Segues
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showWinePairs" {
            let winePairController = (segue.destinationViewController as! WinePairViewController)
            
            let indexPath = collectionView.indexPathsForSelectedItems()?.first
            let foodsInSection = sectionFoods[indexPath!.section]
            let foodType = Foods(rawValue: foodsInSection[indexPath!.row])
            print(foodType?.rawValue)
            winePairController.winePairs = [WinePairTest1, WinePairTest2, WinePairTest3]
            winePairController.closestStoreID = closestStoreID
        }
    }
    
//MARK: CLLocation Manager Delegate
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if (status == CLAuthorizationStatus.AuthorizedWhenInUse) {
            self.locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let lon = locationManager.location?.coordinate.longitude
        let lat = locationManager.location?.coordinate.latitude
        dataManager.closestStore(lat!, longitude: lon!) { (lcboStoreCode) -> Void in
            self.closestStoreID = lcboStoreCode
        }
    }
}