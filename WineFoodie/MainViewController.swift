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
    var winePairingModel = [FoodCategory]()
    
    // MARK: UIViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let storage = FIRStorage.storage()
        let winePairingModelRef = storage.referenceForURL("gs://winefoodie-68a08.appspot.com/WinePairingModel/WinePairingModel.json")
    
        winePairingModelRef.dataWithMaxSize(300000) { (data, error) in
            if let foodCategoryData = data {
                self.saveWinePairingModel(foodCategoryData)
            } else {
                //handle error
                print(error)
            }
        }
    }
    
    func saveWinePairingModel (data: NSData) {
        
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions())
            print(json)
            if let foodCategories = json as? [AnyObject] {
                
                for category in foodCategories {
                    
                    if let jsonFoodCategory = category as? [String : AnyObject] {
                        winePairingModel.append(FoodCategory.withJSON(jsonFoodCategory)!)
                        dispatch_async(dispatch_get_main_queue(), { 
                            self.collectionView.reloadData()
                        })
                    }
                }
            }
            // Fully-packaged, type-safe, valid instance of Wine Pairing Model, with nested models
            print(winePairingModel)
        } catch {
            print(error)
        }
        
        
        
        

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
            let foodsInSection = sectionFoods[indexPath!.section]
            let foodType = Foods(rawValue: foodsInSection[indexPath!.row])
            
            let WinePairTest1 = WinePair(wineGroup: .Red, wineVarietal: "merlot", wineCountry: "usa", wineMatchRating: 0.0)
            let WinePairTest2 = WinePair(wineGroup: .Rose, wineVarietal: "zinfandel", wineCountry: "usa", wineMatchRating: 0.0)
            let WinePairTest3 = WinePair(wineGroup: .White, wineVarietal: "chardonnay", wineCountry: "usa", wineMatchRating: 0.0)

            winePairController.winePairs = [WinePairTest1, WinePairTest2, WinePairTest3]

        }
    }
    

}