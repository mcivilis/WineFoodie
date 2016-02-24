//
//  ModelObjects.swift
//  WineFoodie
//
//  Created by Maria Civilis on 2016-02-22.
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
            print(wine.varietal, wine.region)
        }
    }
}

class WinePair : NSObject {
    var region : String!
    var varietal : String!
    
    init (wineRegion: String, wineVarietal: String) {
        region = wineRegion
        varietal = wineVarietal
    }
    
    override func isEqual(object: AnyObject?) -> Bool {
        if let object = object as? WinePair {
            return equalWinePairs(self, toPair: object)
        } else {
            return false
        }
    }
    
    func equalWinePairs(comparePair:WinePair, toPair:WinePair) -> Bool {
        return comparePair.region == toPair.region && comparePair.varietal == toPair.varietal
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

