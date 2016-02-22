//
//  ModelObjects.swift
//  WineFoodie
//
//  Created by Maria Civilis on 2016-02-22.
//  Copyright © 2016 mcivilis. All rights reserved.
//

import Foundation

struct Wine {
    
    var name : String!
    var code : String!
    var varietal : String!
    var vintage : String!
    var wineType : String!
    var region : String!
    var snoothrank : Int!
    var price : Int!
    var recipes : [Recipe]!
}

struct  Recipe {
    var name: String!
    var link: String!
    var sourceLink: String!
    var sourceID: String!
    var image: String!
}

