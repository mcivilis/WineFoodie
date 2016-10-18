//
//  WinePairLoader.swift
//  WineFoodie
//
//  Created by Masha on 2016-08-17.
//  Copyright © 2016 mcivilis. All rights reserved.
//

import Foundation
import Firebase

protocol WinePairLoaderDelegate {
    func didLoadWinePairs(foodCategories: [FoodCategory])
    func didFinishWithError(errorToDisplay: String)
}

class WinePairLoader {
    
    static let sharedInstance : WinePairLoader = {
        let instance = WinePairLoader()
        return instance
    }()
    
    var winePairLoaderDelegate: WinePairLoaderDelegate?

    func load(delegate: WinePairLoaderDelegate) {
        
        winePairLoaderDelegate = delegate
        
        let storage = FIRStorage.storage()
        let winePairingModelRef = storage.reference(forURL: "gs://winefoodie-68a08.appspot.com/WinePairingModel/WinePairingModel.json")
        
        winePairingModelRef.data(withMaxSize: 300000) { (data, error) in
            if let foodCategoryData = data {
                self.mapJSON(data: (foodCategoryData as NSData) as Data)
            } else {
                //TODO: handle error
                //if let userInfo = error?.userInfo[NSLocalizedDescriptionKey] {
                //    self.winePairLoaderDelegate?.didFinishWithError(userInfo[NSLocalizedDescriptionKey])
                //}
            }
        }
    }
    
    func mapJSON (data: Data) {
        
        do {
            let json = try JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions())
            
            var winePairingModel = [FoodCategory]()
            if let foodCategories = json as? [AnyObject] {
                
                for category in foodCategories {
                    
                    if let jsonFoodCategory = category as? [String : AnyObject] {
                        winePairingModel.append(FoodCategory.withJSON(jsonFoodCategory)!)
                        DispatchQueue.main.async {
                            self.winePairLoaderDelegate?.didLoadWinePairs(foodCategories: winePairingModel)
                        }
                    }
                }
            }
            let error = NSError()
            throw error
        } catch let error as NSError {
            if let errorDescription = error.userInfo[NSLocalizedDescriptionKey] {
                self.winePairLoaderDelegate?.didFinishWithError(errorToDisplay: errorDescription as! String)
            }
        }
    }
}

