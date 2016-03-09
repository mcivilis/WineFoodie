//
//  DataManager+StoreInventory.swift
//  WineFoodie
//
//  Created by Maria Civilis on 2016-03-09.
//  Copyright © 2016 mcivilis. All rights reserved.
//

import Foundation

extension DataManager {
    
    func storeInventory(storeID: Int, productID: Int, completion: (storeInventory: Int) -> Void) {
        
        let url = lcboInventoryURL(storeID, productID: productID)
        let lcboStoreURL = NSURL(string: url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!)
        
        loadDataFromURL(lcboStoreURL!) { (data, error) -> Void in
            guard error == nil else {
                completion(storeInventory: 0)
                return
            }
            
            typealias Payload = [String: AnyObject]
            var json: Payload!
            
            do {
                json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions()) as? Payload
            } catch {
                completion(storeInventory: 0)
                return
            }
            guard let store = json["result"] as? Payload
                else {
                    completion(storeInventory: 0)
                    return
            }
            
            if let quantity = store["quantity"] as? Int {
                completion(storeInventory: quantity)
            } else {
                completion(storeInventory: 0)
            }
        }
    }

}