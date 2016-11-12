//
//  MainViewController.swift
//  WineFoodie
//
//  Created by Maria Civilis on 2016-02-22.
//  Copyright © 2016 mcivilis. All rights reserved.
//

import UIKit
import MapKit

class MainViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, WinePairLoaderDelegate, CLLocationManagerDelegate {
    
    // MARK: Outlets
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var flowLayout: UICollectionViewFlowLayout!

    // MARK: Constants
    let locationManager = CLLocationManager()
    let dataManager = DataManager()
    
    
    //MARK: Properties
    var initialLocationSet = false
    var closestStoreID = 511 //Defaults to King & Spadina store location
    var winePairingModel = [FoodCategory]()
    
    // MARK: UIViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        WinePairLoader.sharedInstance.load(delegate: self)
        
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self;
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: kWineFoodie.notifications.currentPostalCode), 
                                               object: nil, 
                                               queue: nil, 
                                               using: currentPostalCodeReceivedNotifcation)
    }
    

    //MARK: Wine Pair Loader Delegate
    func didLoadWinePairs(foodCategories: [FoodCategory]) {
        winePairingModel = foodCategories;
        self.collectionView.reloadData()
    }
    func didFinishWithError(errorToDisplay: String) {
        let alert = UIAlertController(title: "Error", message: "Could not load wine pairing recommendations", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    //MARK: CLLocation Manager Delegate
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if (status == CLAuthorizationStatus.authorizedWhenInUse) {
            self.locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if (initialLocationSet == false) {
            if let userLocation = locationManager.location {
                getCurrentPostalCodeForLocation(location: userLocation)}
            initialLocationSet = true
        }
    }
    
    //MARK: Collection View Data Source
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return winePairingModel[section].foods.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! FoodCell
        let food = winePairingModel[(indexPath as NSIndexPath).section].foods[(indexPath as NSIndexPath).row]
        cell.foodLabel.text = food.name
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return winePairingModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var reusableview : UICollectionReusableView!
        if (kind == UICollectionElementKindSectionHeader) {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "Header", for: indexPath) as! FoodHeader
            header.headerLabel.text = winePairingModel[(indexPath as NSIndexPath).section].name
            reusableview = header;
        }
        return reusableview
    }
    

// MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showWinePairs" {
            
            let winePairController = (segue.destination as! WinePairViewController)
            let indexPath = collectionView.indexPathsForSelectedItems?.first
            let foodCategory = winePairingModel[(indexPath! as NSIndexPath).section]
            let food = foodCategory.foods[(indexPath! as NSIndexPath).row]
            winePairController.winePairs = food.winePairs
        }
    }
    
// MARK: Helpers
    
    func getCurrentPostalCodeForLocation(location: CLLocation) {
        
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error)->Void in
            
            if let isError = error {
                print(isError)
                return
            } else {
                let placemark = placemarks![0] as CLPlacemark
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: kWineFoodie.notifications.currentPostalCode),
                                        object: placemark.postalCode)
            }
        })
    }
    
    func currentPostalCodeReceivedNotifcation(notification:Notification) -> Void {
        
        if let postalCode = notification.object as? String {
            print(postalCode)
            //TODO: GET THE STORE ID FOR THE CLOSEST STORE!!!
        }
    }

}
