//
//  MainViewController.swift
//  WineFoodie
//
//  Created by Maria Civilis on 2016-02-22.
//  Copyright © 2016 mcivilis. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, WinePairLoaderDelegate {
    
    // MARK: Outlets
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var flowLayout: UICollectionViewFlowLayout!

    // MARK: Constants
    let dataManager = DataManager()
    
    
    //MARK: Properties
    var initialLocationSet = false
    var winePairingModel = [FoodCategory]()
    
    // MARK: UIViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        WinePairLoader.sharedInstance.load(delegate: self)
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
        alert.view.tintColor = kWineFoodie.colors.burgundy
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

}
