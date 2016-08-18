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
    
    var delegate: WinePairLoaderDelegate?
    
    class var sharedInstance: WinePairLoader {
        
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var instance: WinePairLoader? = nil
        }
        
        dispatch_once(&Static.onceToken) {
            Static.instance = WinePairLoader()
        }
        return Static.instance!
    }
    
    func load() {
        
        let storage = FIRStorage.storage()
        let winePairingModelRef = storage.referenceForURL("gs://winefoodie-68a08.appspot.com/WinePairingModel/WinePairingModel.json")
        
        winePairingModelRef.dataWithMaxSize(300000) { (data, error) in
            if let foodCategoryData = data {
                self.mapJSON(foodCategoryData)
            } else {
                if let userInfo = error?.userInfo[NSLocalizedDescriptionKey] {
                    self.delegate?.didFinishWithError(userInfo[NSLocalizedDescriptionKey])
                }
            }
        }
    }
    
    func mapJSON (data: NSData) {
        
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions())
            
            var winePairingModel = [FoodCategory]()
            if let foodCategories = json as? [AnyObject] {
                
                for category in foodCategories {
                    
                    if let jsonFoodCategory = category as? [String : AnyObject] {
                        winePairingModel.append(FoodCategory.withJSON(jsonFoodCategory)!)
                        dispatch_async(dispatch_get_main_queue(), {
                            self.delegate?.didLoadWinePairs(winePairingModel)
                        })
                    }
                }
            }
        } catch {
            if let userInfo = error?.userInfo[NSLocalizedDescriptionKey] {
                self.delegate?.didFinishWithError(userInfo[NSLocalizedDescriptionKey])
            }
        }
    }
    
}

