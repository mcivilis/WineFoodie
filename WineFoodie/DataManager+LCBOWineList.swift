//
//  DataManager+LCBOWineList.swift
//  WineFoodie
//
//  Created by Maria Civilis on 2016-02-25.
//  Copyright © 2016 mcivilis. All rights reserved.
//

import Foundation



extension DataManager {
    func lcboWineList (winePair: WinePair) {
        pager(winePair) { (pages) -> Void in
            var counter = 0
            for page in 1...pages {
                self.pageWineList(winePair, page: page, completion: { (pageWineList) -> Void in
                    counter++
                    self.delegate!.didUpdateWineList()
                    self.wineList = self.wineList + pageWineList
                })
            }
        }
    }
    
    func pager (winePair: WinePair, completion: (pages: Int) -> Void) {
        let url = lcboWinesURL(winePair)
        let pagerURL = NSURL(string: url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!)
        
        loadDataFromURL(pagerURL!) { (data, error) -> Void in
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
            
            guard let pager = json["pager"] as? Payload
                else {
                    print("No page data found")
                    return
            }
            if let numberOfPages = pager["total_pages"] as? Int {
                completion(pages: numberOfPages)
            } else {
                completion(pages: 1)
            }
        }
    }
    
    func pageWineList (winePair: WinePair, page: Int, completion: (pageWineList: [LCBOWine]) -> Void) {
        let url = lcboWinesURLForPage(winePair, page: page)
        let lcboProductURL = NSURL(string: url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!)
        loadDataFromURL(lcboProductURL!) { (data, error) -> Void in
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
            guard let wines = json["result"] as? [Payload]
                else {
                    print("No wines found")
                    return
            }
            
            var lcboWineList = [LCBOWine]()
            var counter = 0
            
            for wine in wines {
                counter++
                var include = false
                if let category = wine["primary_category"] as? String,
                    let subCategory = wine["secondary_category"] as? String {
                        if (category == "Wine" && (subCategory == "Rosé Wine" || subCategory == "White Wine" || subCategory == "Red Wine" || subCategory == "Dessert Wine" || subCategory == "Sparkling Wine")) {
                            include = true
                        }
                }
                
                if (include == true) {
                    if let lcboName = wine["name"] as? String,
                        let lcboCurrentPrice = wine["price_in_cents"] as? Int,
                        let lcboRegularPrice = wine["regular_price_in_cents"] as? Int,
                        let lcboPriceSavings = wine["limited_time_offer_savings_in_cents"] as? Int,
                        let lcboPrimaryCategory = wine["primary_category"] as? String,
                        let lcboSecondaryCategory = wine["secondary_category"] as? String,
                        let lcboOrigin = wine["origin"] as? String,
                        let lcboInventoryCount = wine["inventory_count"] as? Int,
                        let lcboSugarContent = wine["sugar_content"] as? String,
                        let lcboSugarInGrams = wine["sugar_in_grams_per_liter"] as? Int,
                        let lcboProducerName = wine["producer_name"] as? String,
                        let lcboIsSeasonal = wine["is_seasonal"] as? Bool,
                        let lcboIsVQA = wine["is_vqa"] as? Bool,
                        let lcboImageThumbURL = wine["image_thumb_url"] as? String,
                        let lcboImageURL = wine["image_url"] as? String,
                        let lcboVarietal = wine["varietal"] as? String,
                        let lcboStyle = wine["style"] as? String!,
                        let lcboCode = wine["id"] as? Int! {
                            
                            let lcboWine = LCBOWine(name: lcboName, currentPrice: lcboCurrentPrice, regularPrice: lcboRegularPrice, priceSavings: lcboPriceSavings, primaryCategory: lcboPrimaryCategory, secondaryCategory: lcboSecondaryCategory, origin: lcboOrigin, inventoryCount: lcboInventoryCount, sugarContent: lcboSugarContent, sugarInGrams: lcboSugarInGrams, producerName: lcboProducerName, isSeasonal: lcboIsSeasonal, isVQA: lcboIsVQA, imageThumbURL: lcboImageThumbURL, imageURL: lcboImageURL, varietal: lcboVarietal, style: lcboStyle, matchRating: 0, code: lcboCode)
                            
                            self.storeInventory(511, productID: lcboWine.code) { (storeInventory) -> Void in
                                if (storeInventory > 0) {
                                    lcboWineList.append(lcboWine)
                                }
                                if (counter == wines.count) {
                                    completion(pageWineList: lcboWineList)
                                }
                            }
                    }
                }
            }
            
        }
    }
}
