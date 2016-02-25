//
//  FoodDefinitions.swift
//  WineFoodie
//
//  Created by Maria Civilis on 2016-02-24.
//  Copyright © 2016 mcivilis. All rights reserved.
//

import Foundation


enum Foods : String {
    case Beef       = "Beef"
    case Pork       = "Pork"
    case Salmon     = "Salmon"
    case WhiteFish  = "White Fish"
}

//Recipe search keywords

let foods =
   ["Beef",                                                     //Food = Beef
    "Pork",                                                     //Food = Pork
    "Salmon",                                                   //Food = Salmon
    "Basa", "Cod", "Tilapia",                                   //Food = WhiteFish
    "Tuna",                                                     //Food = ?
    "Chicken","Turkey",                                         //Food = ?
    "Shrimp", "Oysters", "Mussels","Prawns", "Lobster",         //Food = ?
    "Veal",                                                     //Food = ?
    "Lamb",                                                     //Food = ?
    "Duck",                                                     //Food = ?
    "Goat Cheese",                                              //Food = ?
    "Roquefort",                                                //Food = ?
    "Camembert",                                                //Food = ?
    "Brie",                                                     //Food = ?
    "Blue Cheese",                                              //Food = ?
    "Gouda",                                                    //Food = ?
    "Parmigiano"]                                               //Food = ?


class FoodDefinitions {
    
    func keywordsforFood(food: Foods) -> [String] {
        switch food {
        case .Beef          : return ["Beef"]
        case .Pork          : return ["Pork"]
        case .Salmon        : return ["Salmon"]
        case .WhiteFish     : return ["Basa", "Cod", "Tilapia"]
        }
    }
    
}
