//
//  MainViewController.swift
//  WineFoodie
//
//  Created by Maria Civilis on 2016-02-22.
//  Copyright © 2016 mcivilis. All rights reserved.
//

import UIKit
import MapKit

class MainViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, WinePairLoaderDelegate {
    
    // MARK: Outlets
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var flowLayout: UICollectionViewFlowLayout!

    // MARK: Constants
    let locationManager = CLLocationManager()
    let dataManager = DataManager()
    
    //MARK: Properties
    var closestStoreID = 511 //Defaults to King & Spadina store location
    var winePairingModel = [FoodCategory]()
    
    // MARK: UIViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: Wine Pair Loader Delegate
    func didLoadWinePairs(foodCategories: [FoodCategory]) {
//success
}
func didFinishWithError(errorToDisplay: String) {
//error
}

    
    //MARK: Collection View Data Source
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return winePairingModel[section].foods.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! FoodCell
        let food = winePairingModel[indexPath.section].foods[indexPath.row]
        cell.foodLabel.text = food.name
        return cell
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return winePairingModel.count
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        var reusableview : UICollectionReusableView!
        if (kind == UICollectionElementKindSectionHeader) {
            let header = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "Header", forIndexPath: indexPath) as! FoodHeader
            header.headerLabel.text = winePairingModel[indexPath.section].name
            reusableview = header;
        }
        return reusableview
    }
    

// MARK: - Segues
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showWinePairs" {
            
            let winePairController = (segue.destinationViewController as! WinePairViewController)
            let indexPath = collectionView.indexPathsForSelectedItems()?.first
            let foodCategory = winePairingModel[indexPath!.section]
            let food = foodCategory.foods[indexPath!.row]
            winePairController.winePairs = food.winePairs
        }
    }
    

}