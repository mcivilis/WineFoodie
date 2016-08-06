//
//  MainViewController.swift
//  WineFoodie
//
//  Created by Maria Civilis on 2016-02-22.
//  Copyright © 2016 mcivilis. All rights reserved.
//

import UIKit
import MapKit
import Firebase

class MainViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    // MARK: Outlets
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var flowLayout: UICollectionViewFlowLayout!

    // MARK: Constants
    let locationManager = CLLocationManager()
    let dataManager = DataManager()
    
    //MARK: Properties
    var closestStoreID = 511 //Defaults to King & Spadina store location
    var rootRef: FIRDatabaseReference!
    
    // MARK: UIViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rootRef = FIRDatabase.database().reference()
        let foodCategoriesRef = rootRef.child("FoodCategories")
        
        foodCategoriesRef.observeEventType(.Value) { (snap: FIRDataSnapshot) in
            print(snap.value)
        }
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
            
            let WinePairTest1 = WinePair(wineGroup: .Red, wineVarietal: "merlot", wineCountry: "usa", wineMatchRating: 0.0)
            let WinePairTest2 = WinePair(wineGroup: .Rose, wineVarietal: "zinfandel", wineCountry: "usa", wineMatchRating: 0.0)
            let WinePairTest3 = WinePair(wineGroup: .White, wineVarietal: "chardonnay", wineCountry: "usa", wineMatchRating: 0.0)

            winePairController.winePairs = [WinePairTest1, WinePairTest2, WinePairTest3]

        }
    }
    

}