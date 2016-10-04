//
//  DataManager+Options.swift
//  WineFoodie
//
//  Created by Maria Civilis on 2016-03-08.
//  Copyright © 2016 mcivilis. All rights reserved.
//

import Foundation

let kAPI_KEY = "?access_key=" + "MDpkZTFhZmYyNi1kOThlLTExZTUtYmZiNy02M2I1YzUwOTAwNjI6WUpVd0xQckJEVVdEWDBLVGJNeWFTZkpUOXVRQmhTU2x6WDMw"
let kPRODUCTS_API = "http://lcboapi.com/products"
let kPRODUCTS_OPTIONS = "?where_not=is_dead&order=inventory_count.desc&per_page=100"
let kSTORES_API = "http://lcboapi.com/stores"
let kSTORES_OPTIONS = "&order=distance_in_meters.desc"
let kSTORES_PER_PAGE = "&per_page=20"


extension DataManager {
    
    func lcboWinesURL(_ winePair: WinePair) -> String {
        return kPRODUCTS_API + kAPI_KEY + kPRODUCTS_OPTIONS + "&q=" + prepareWinePairString(winePair)
    }
    
    func prepareWinePairString(_ winePair: WinePair) -> String {
        let wineGroup = winePair.group.rawValue
        let varietal = winePair.varietal
        let country = winePair.country
        let plus = "+"
        return wineGroup + plus + varietal! + plus + country!
    }

    func lcboStoresURL(_ latitude: Double, longitude: Double, productID: Int) -> String {
        return kSTORES_API + "?lat=" + latitude.description + "&" + "lon=" + longitude.description  + "&product_id=" + productID.description + kSTORES_OPTIONS + kSTORES_PER_PAGE
    }

    func lcboClosestStoreURL(_ latitude: Double, longitude: Double) -> String {
        return kSTORES_API + "?lat=" + latitude.description + "&" + "lon=" + longitude.description  + "&product_id=" + kSTORES_OPTIONS
    }

    func lcboInventoryURL(_ storeID: Int, productID: Int) -> String {
        return kSTORES_API + "/" + storeID.description + "/products/" + productID.description + "/inventory"
    }
    
}
