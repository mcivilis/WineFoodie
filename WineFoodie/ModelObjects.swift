//
//  ModelObjects.swift
//  WineFoodie
//
//  Created by Masha on 2016-08-06.
//  Copyright © 2016 mcivilis. All rights reserved.
//

import Foundation

struct FoodCategory {
    let name: String
    let foods: [Food]
    
    init(name: String, foods: [Food]) {
        self.name = name
        self.foods = foods
    }
}

struct Food {
    let name: String
    let winePairs: [WinePair]
    
    init(name: String, winePairs: [WinePair]) {
        self.name = name
        self.winePairs = winePairs
    }
}

enum WineGroup : String {
    case Red        = "Red Wine"
    case White      = "White Wine"
    case Rose       = "Rosé Wine"
    case Sparkling  = "Sparkling Wine"
    case Dessert    = "Dessert Wine"
}

struct WinePair : Equatable, Hashable {
    var group : WineGroup!
    var varietal : String!
    var country : String!
    var matchRating : Float!
    
    var hashValue: Int{
        return (group.rawValue + varietal + country + matchRating.description).hashValue
    }
    
    init (wineGroup: WineGroup, wineVarietal: String!, wineCountry: String!, wineMatchRating: Float!) {
        group = wineGroup
        varietal = wineVarietal
        country = wineCountry
        matchRating = wineMatchRating
    }
}

func == (lhs:WinePair, rhs:WinePair) -> Bool {
    return ((lhs.varietal == rhs.varietal) && (lhs.country == rhs.country))
}

func wineGroup(group: String) -> WineGroup {
    
    if group == "red" {
        return .Red
    } else if group == "white" {
        return .White
    } else if group == "rose" {
        return .Rose
    } else if group == "sparkling" {
        return .Sparkling
    } else if group == "dessert" {
        return .Dessert
    } else {
        return .Red
    }
}

struct LCBOStore {
    var id: Int!
    var name: String!
    var address: String!
    var city: String!
    var postalCode: String!
    var telephone: String!
    var latitude: Double!
    var longitude: Double!
    var hasParking: Bool!
    var distanceInMeters: Int!
    var quantity: Int!
    
}

struct LCBOWine : Equatable {
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
    var imageThumbURL: String!
    var imageURL: String!
    var varietal: String!
    var style: String!
    var code: Int!
    var stockType: String!
    var isKosher: Bool!
}

func == (lhs:LCBOWine, rhs:LCBOWine) -> Bool {
    return (lhs.code == rhs.code)
}