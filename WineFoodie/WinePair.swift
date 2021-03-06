//
//  WinePair.swift
//  WineFoodie
//
//  Created by Maria Civilis on 2016-03-08.
//  Copyright © 2016 mcivilis. All rights reserved.
//

import Foundation

extension WinePair : JSONParselable {
    
    static func withJSON(_ json: [String : AnyObject]) -> WinePair? {
        guard
            let group = string(json, key: "group"),
            let varietal = string(json, key: "varietal"),
            let country = string(json, key: "country"),
            let matchRating = float(json, key: "match_rating")
            else {
                return nil
        }
        return WinePair(wineGroup: wineGroup(group), wineVarietal: varietal, wineCountry: country, wineMatchRating: matchRating)
    }
}
