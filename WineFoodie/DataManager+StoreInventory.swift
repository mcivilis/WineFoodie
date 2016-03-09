//
//  DataManager+StoreInventory.swift
//  WineFoodie
//
//  Created by Maria Civilis on 2016-03-09.
//  Copyright © 2016 mcivilis. All rights reserved.
//

import Foundation

extension DataManager {
    
    func storeInventory (latitude: Double, longitude: Double, productID: Int) {
        
        let url = lcboStoresURL(latitude, longitude: longitude, productID: productID)
        let lcboStoreURL = NSURL(string: url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!)
        
        loadDataFromURL(lcboStoreURL!) { (data, error) -> Void in
            guard error == nil else {
                print(error)
                return
            }
            
            typealias Payload = [String: AnyObject]
            var json: Payload!
            
            do {
                json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions()) as? Payload
            } catch {
                print(error)
                return
            }
            guard let stores = json["result"] as? [Payload]
                else {
                    print("No stores found")
                    return
            }
            var inventory = 0
            for store in stores {
                if let storeQuantity = store["quantity"] as? Int {
                   inventory = inventory + storeQuantity
                    if (self.storeInventory.count == stores.count) {
                        self.delegate?.didUpdateInventory()
                        self.storeInventory[productID] = inventory
                    }
                }
            }
        }
    }

}