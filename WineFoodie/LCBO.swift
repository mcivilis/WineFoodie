//
//  LCBO.swift
//  WineFoodie
//
//  Created by Maria Civilis on 2016-03-08.
//  Copyright © 2016 mcivilis. All rights reserved.
//

import Foundation

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
    var imageThumbURL: String!
    var imageURL: String!
    var varietal: String!
    var style: String!
    var matchRating : Float!
    var code: Int!
}
