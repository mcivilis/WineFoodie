//
//  WinePair.swift
//  WineFoodie
//
//  Created by Maria Civilis on 2016-03-08.
//  Copyright © 2016 mcivilis. All rights reserved.
//

import Foundation

enum WineGroup : String {
    case Red        = "Red Wine"
    case White      = "White Wine"
    case Rose       = "Rosé Wine"
    case Sparkling  = "Sparkling Wine"
    case Dessert    = "Dessert Wine"
}

class WinePair : Equatable, Hashable {
    
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

let WinePairTest1 = WinePair(wineGroup: .Red, wineVarietal: "merlot", wineCountry: "usa", wineMatchRating: 0.0)
let WinePairTest2 = WinePair(wineGroup: .Rose, wineVarietal: "zinfandel", wineCountry: "usa", wineMatchRating: 0.0)
let WinePairTest3 = WinePair(wineGroup: .White, wineVarietal: "chardonnay", wineCountry: "usa", wineMatchRating: 0.0)
