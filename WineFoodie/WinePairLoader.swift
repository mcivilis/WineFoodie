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
    
    var delegate: WinePairLoaderDelegate?

    func load() {
        
        let storage = FIRStorage.storage()
        let winePairingModelRef = storage.reference(forURL: "gs://winefoodie-68a08.appspot.com/WinePairingModel/WinePairingModel.json")
        
        winePairingModelRef.data(withMaxSize: 300000) { (data, error) in
            if let foodCategoryData = data {
                self.mapJSON(data: (foodCategoryData as NSData) as Data)
            } else {
//                if let userInfo = error?.userInfo[NSLocalizedDescriptionKey] {
//                    self.delegate?.didFinishWithError(userInfo[NSLocalizedDescriptionKey])
//                }
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
                            self.delegate?.didLoadWinePairs(foodCategories: winePairingModel)
                        }
                    }
                }
            }
        } catch {
//            if let userInfo = error.userInfo[NSLocalizedDescriptionKey] {
//                self.delegate?.didFinishWithError(userInfo[NSLocalizedDescriptionKey])
//            }
        }
    }
    
}

