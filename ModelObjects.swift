//
//  ModelObjects.swift
//  WineFoodie
//
//  Created by Maria Civilis on 2016-02-22.
//  Copyright © 2016 mcivilis. All rights reserved.
//

import Foundation

class Wine {
    var code : String!
    var region : String!
    var varietal : String!
    var type: String!
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

