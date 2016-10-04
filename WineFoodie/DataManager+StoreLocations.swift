//
//  DataManager+StoreLocations.swift
//  WineFoodie
//
//  Created by Maria Civilis on 2016-03-01.
//  Copyright © 2016 mcivilis. All rights reserved.
//

import Foundation

extension DataManager {
    
    func storeLocations (_ latitude: Double, longitude: Double, productID: Int, completion: @escaping (_ lcboStoreList: [LCBOStore]) -> Void) {
        
        let url = lcboStoresURL(latitude, longitude: longitude, productID: productID)
        let lcboStoreURL = URL(string: url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)
        
        loadDataFromURL(lcboStoreURL!) { (data, error) -> Void in
            guard error == nil else {
                print(error)
                return
            }
            
            typealias Payload = [String: AnyObject]
            var json: Payload!
            
            do {
                json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions()) as? Payload
            } catch {
                print(error)
                return
            }
            guard let stores = json["result"] as? [Payload]
                else {
                    print("No stores found")
                    return
            }
            
            var lcboStoreList = [LCBOStore]()
            
            for store in stores {
                
                if let storeID = store["id"] as? Int,
                    let storeName = store["name"] as? String,
                    let storeAddress = store["address_line_1"] as? String,
                    let storeCity = store["city"] as? String,
                    let storePostalCode = store["postal_code"] as? String,
                    let storeTelephone = store["telephone"] as? String,
                    let storeLatitude = store["latitude"] as? Double,
                    let storeLongitude = store["longitude"] as? Double,
                    let storeHasParking = store["has_parking"] as? Bool,
                    let storeDistanceInMeters = store["distance_in_meters"] as? Int,
                    let storeQuantity = store["quantity"] as? Int {
                        
                        let lcboStore = LCBOStore(id: storeID, name: storeName, address: storeAddress, city: storeCity, postalCode: storePostalCode, telephone: storeTelephone, latitude: storeLatitude, longitude: storeLongitude, hasParking: storeHasParking, distanceInMeters: storeDistanceInMeters, quantity: storeQuantity)
                        lcboStoreList.append(lcboStore)
                }
            }
            completion(lcboStoreList: lcboStoreList)
        }
    }
    
    
}
