//
//  WinePairingObjects.swift
//  WineFoodie
//
//  Created by Maria Civilis on 2016-02-24.
//  Copyright © 2016 mcivilis. All rights reserved.
//

import Foundation

enum Foods : String {
    case Beef = "Beef"
    case Pork = "Pork"
    case Salmon = "Salmon"
    case WhiteFish = "White Fish"
}


class WinePairingModel {
    
    var sparklingWineList = [WinePair]()
    var redWineLinst = [WinePair]()
    var whiteWineList = [WinePair]()
    var roseWineList = [WinePair]()
    var desserWineList = [WinePair]()
    
    func printWineList(wineList: [WinePair]) {
        for wine in wineList {
            print(wine.country, wine.region, wine.varietal)
        }
    }
}

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

func == (lhs:WinePair, rhs:WinePair) -> Bool {
    return ((lhs.varietal == rhs.varietal) && (lhs.country == rhs.country) && (lhs.region == rhs.region))
}

