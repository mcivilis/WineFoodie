//
//  ModelObjects.swift
//  WineFoodie
//
//  Created by Maria Civilis on 2016-02-22.
//  Copyright © 2016 mcivilis. All rights reserved.
//

import Foundation

struct LCBOWine {
    
    var name : String!
    var currentPrice: Int!
    var regularPrice: Int!
    var priceSavings: Int!
    var primaryCategory: String!
    var secondaryCategory: String!
    var origin: String!
    var inventoryCount: Int!
    var sugarContent: String!
    var sugarInGrams: Int!
    var producerName: String!
    var isSeasonal: Bool!
    var isVQA: Bool!
    var imageURL: String!
    var varietal: String!
    var style: String!
    var matchRating : Float!
    var code: Int!
}

class WinePair : Equatable, Hashable {
    
    var varietal : String!
    var country : String!
    var matchRating : Float!
    var hashValue: Int{
        return (varietal + country).hashValue
    }
    
    init (wineRegion: String, wineVarietal: String) {
        varietal = wineVarietal
        country = WinePair.getCountry(wineRegion)
        matchRating = 0
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
    return ((lhs.varietal == rhs.varietal) && (lhs.country == rhs.country))
}