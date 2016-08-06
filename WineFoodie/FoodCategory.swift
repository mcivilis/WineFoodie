//
//  FoodCategory.swift
//  WineFoodie
//
//  Created by Masha on 2016-08-06.
//  Copyright © 2016 mcivilis. All rights reserved.
//

import Foundation

extension FoodCategory : JSONParselable {
    
    static func withJSON(json: [String : AnyObject]) -> FoodCategory? {
        guard
            let name = string(json, key: "name")
            else {
                return nil
        }
        
        let foodDicts = json["foods"] as? [[String:AnyObject]]
        func sanitizedFoods(dicts: [[String:AnyObject]]?) -> [Food] {
            guard let dicts = dicts else {
                return [Food]()
            }
            return dicts.flatMap { Food.withJSON($0) }
        }
        return FoodCategory(name: name, foods: sanitizedFoods(foodDicts))
    }
}