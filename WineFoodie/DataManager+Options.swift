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
let kPRODUCTS_OPTIONS = "?where_not=is_dead"
let kSTORES_API = "http://lcboapi.com/stores"
let kSTORES_OPTIONS = "&order=distance_in_meters.desc"
let kSTORES_PER_PAGE = "&per_page=20"


extension DataManager {

//WINES
    func lcboWinesURLForPage(winePair: WinePair, page:Int) -> String {
        let page = "?page=" + page.description
        return kPRODUCTS_API + page + kAPI_KEY + kPRODUCTS_OPTIONS + "&q=" + prepareWinePairString(winePair)
    }
    
    func lcboWinesURL(winePair: WinePair) -> String {
        return kPRODUCTS_API + kAPI_KEY + kPRODUCTS_OPTIONS + "&q=" + prepareWinePairString(winePair)
    }
    
    func prepareWinePairString(winePair: WinePair) -> String {
        let wineGroup = winePair.group.rawValue
        let varietal = winePair.varietal
        let country = winePair.country
        let plus = "+"
        return wineGroup + plus + varietal + plus + country
    }
    
//STORES
    func lcboStoresURL(latitude: Double, longitude: Double, productID: Int) -> String {
        return kSTORES_API + "?lat=" + latitude.description + "&" + "lon=" + longitude.description  + "&product_id=" + productID.description + kSTORES_OPTIONS + kSTORES_PER_PAGE
    }
    
}