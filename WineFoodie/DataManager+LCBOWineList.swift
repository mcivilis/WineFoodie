//
//  DataManager+LCBOWineList.swift
//  WineFoodie
//
//  Created by Maria Civilis on 2016-02-25.
//  Copyright © 2016 mcivilis. All rights reserved.
//

import Foundation



extension DataManager {
    func lcboWineList (_ winePair: WinePair) {
        var counter = 0
        wines(winePair) { (wineListForPair) -> Void in
            for wine in wineListForPair {
                
                if (!(self.wineList.contains(wine))) {
                    self.wineList.append(wine)
                }
                counter += 1
                if (counter == wineListForPair.count) {
                    self.delegate?.didUpdateWineList()
                }
            }
        }
    }
    
    
    func wines (_ winePair: WinePair, completion: @escaping (_ wineListForPair: [LCBOWine]) -> Void) {
        let url = lcboWinesURL(winePair)
        let lcboProductURL = URL(string: url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)
        loadDataFromURL(lcboProductURL!) { (data, error) -> Void in
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
            guard let wines = json["result"] as? [Payload]
                else {
                    return
            }
            var wineList = [LCBOWine]()
            for wine in wines {
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
                    let lcboCode = wine["id"] as? Int!,
                    let lcboStockType = wine["stock_type"] as? String,
                    let lcboIsKosher = wine["is_kosher"] as? Bool {
                        
                        let lcboWine = LCBOWine(name: lcboName, currentPrice: lcboCurrentPrice, regularPrice: lcboRegularPrice, priceSavings: lcboPriceSavings, primaryCategory: lcboPrimaryCategory, secondaryCategory: lcboSecondaryCategory, origin: lcboOrigin, inventoryCount: lcboInventoryCount, sugarContent: lcboSugarContent, sugarInGrams: lcboSugarInGrams, producerName: lcboProducerName, isSeasonal: lcboIsSeasonal, isVQA: lcboIsVQA, imageThumbURL: lcboImageThumbURL, imageURL: lcboImageURL, varietal: lcboVarietal, style: lcboStyle, code: lcboCode, stockType: lcboStockType, isKosher: lcboIsKosher)
                        wineList.append(lcboWine)
                }
             completion(wineListForPair: wineList)
            }
            
        }
    }
}
