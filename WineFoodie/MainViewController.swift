//
//  MainViewController.swift
//  WineFoodie
//
//  Created by Maria Civilis on 2016-02-22.
//  Copyright © 2016 mcivilis. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, DataManagerDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
    
//MARK: Properties
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var flowLayout: UICollectionViewFlowLayout!
    
    var dataManager = DataManager()
    var sectionFoods = groupedFoods
    var sectionNames = Array(groupedFoods.keys)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataManager.delegate = self
        dataManager.loadWines()
        print("Started loading snooth model")
    }

//MARK: Data Manager Delegate

    func didUpdateWineListWithOptions(optionsUpdated: Int) {
        if optionsUpdated == dataManager.queryOptions().count {
            print("Finished loading wine list")
            self.dataManager.loadRecipes()
        }
    }

    func didUpdateRecepes(recipesUpdated: Int) {
        //optional
    }

//MARK: Collection View Data Source
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let foodInSection = sectionFoods[sectionNames[section]] as [String]!
        return foodInSection.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! FoodCell
        let foodInSection = sectionFoods[sectionNames[indexPath.section]] as [String]!
        cell.foodLabel.text = foodInSection[indexPath.row]
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
    
    
    
//MARK: Collection View Delegate
    


// MARK: - Segues
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showWinePairs" {
            let winePairController = (segue.destinationViewController as! WinePairViewController)
            
            if let indexPath = collectionView.indexPathsForSelectedItems()?.first {
                let foodInSection = sectionFoods[sectionNames[indexPath.section]] as [String]!
                if let foodType = Foods(rawValue: foodInSection[indexPath.row]) {
                    winePairController.foodType = foodType
                    print(foodType)
                }
            }
            winePairController.dataManager = dataManager
        }
    }












}