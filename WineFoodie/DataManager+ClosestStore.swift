//
//  DataManager+ClosestStore.swift
//  WineFoodie
//
//  Created by Maria Civilis on 2016-03-09.
//  Copyright © 2016 mcivilis. All rights reserved.
//

import Foundation

extension DataManager {
    
    func closestStore (latitude: Double, longitude: Double, completion: (lcboStoreCode: Int) -> Void) {
        
        let url = lcboClosestStoreURL(latitude, longitude: longitude)
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
            
            let store = stores[0]
            if let storeID = store["id"] as? Int {
                completion(lcboStoreCode: storeID)
            } else {
                completion(lcboStoreCode: 511) //Defaults to King & Spadina store
            }
        }
    }
    
    
}
