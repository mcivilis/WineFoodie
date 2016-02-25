//
//  ModelObjects.swift
//  WineFoodie
//
//  Created by Maria Civilis on 2016-02-22.
//  Copyright © 2016 mcivilis. All rights reserved.
//

import Foundation

class WinePair : Equatable, Hashable {
    var varietal : String!
    var country : String!
    var region: String!
    
    var hashValue: Int{
        return (varietal + country + region).hashValue
    }
    
    init (wineRegion: String, wineVarietal: String) {
        varietal = wineVarietal
        country = WinePair.getCountry(wineRegion)
        region = WinePair.getRegion(wineRegion)
    }
    
    class func getCountry(wineRegion: String) -> String {
        let components = wineRegion.componentsSeparatedByString(" > ")
        var country : String!
        if components.count != 0 {
            country = components[0]
        } else {
            country = ""
        }
        return country
    }
    
    class func getRegion(wineRegion: String) -> String {
        let components = wineRegion.componentsSeparatedByString(" > ")
        var region : String!
        if components.count > 1 {
            region = components[1]
        } else {
            region = ""
        }
        return region
    }
}

class Wine {
    var code : String!
    var region : String!
    var varietal : String!
    var type: String!
    var foods : [String]?
    var recipes: [Recipe]?
    
    init(wineCode: String, wineRegion: String, wineVarietal:String, wineType:String) {
        code = wineCode
        region = wineRegion
        varietal = wineVarietal
        type = wineType
    }
}

struct  Recipe {
    var name: String!
    var link: String?
    var sourceLink: String?
    var sourceID: String?
    var image: String?
    
    init(recipeName: String) {
        name = recipeName
    }
}

func == (lhs:WinePair, rhs:WinePair) -> Bool {
    return ((lhs.varietal == rhs.varietal) && (lhs.country == rhs.country) && (lhs.region == rhs.region))
}