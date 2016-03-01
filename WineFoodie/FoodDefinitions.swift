//
//  FoodDefinitions.swift
//  WineFoodie
//
//  Created by Maria Civilis on 2016-02-24.
//  Copyright © 2016 mcivilis. All rights reserved.
//

import Foundation

let groupedFoods = [
    "Meat"     : ["Beef", "Pork", "Veal", "Lamb", "Poultry", "Duck"],
    "Seafood"  : ["Salmon", "Whitefish", "Tuna", "Shellfish"],
    "Cheese"   : ["Goat Cheese", "Roquefort", "Camembert", "Brie", "Blue Cheese", "Gouda", "Parmigiano"]
]

enum Foods : String {
    //Meat
    case Beef       = "Beef"
    case Pork       = "Pork"
    case Veal       = "Veal"
    case Lamb       = "Lamb"
    case Poultry    = "Poultry"
    case Duck       = "Duck"
    
    //Seafood
    case Salmon     = "Salmon"
    case WhiteFish  = "White Fish"
    case Tuna       = "Tuna"
    case Shellfish  = "Shellfish"
    
    //Cheese
    case GoatCheese = "Goat Cheese"
    case Roquefort  = "Roquefort"
    case Camembert  = "Camembert"
    case Brie       = "Brie"
    case BlueCheese = "Blue Cheese"
    case Gouda      = "Gouda"
    case Parmigiano = "Parmigiano"
    
    
}

//Recipe search keywords

let foods =
   ["Beef",                                                     //Food = Beef
    "Pork",                                                     //Food = Pork
    "Veal",                                                     //Food = Veal
    "Lamb",                                                     //Food = Lamb
    "Chicken","Turkey",                                         //Food = Poultry
    "Duck",                                                     //Food = Duck
    "Salmon",                                                   //Food = Salmon
    "Basa", "Cod", "Tilapia",                                   //Food = WhiteFish
    "Tuna",                                                     //Food = Tuna
    "Shrimp", "Oysters", "Mussels","Prawns", "Lobster",         //Food = Shellfish
    "Goat Cheese",                                              //Food = Goat Cheese
    "Roquefort",                                                //Food = Roquefort
    "Camembert",                                                //Food = Camembert
    "Brie",                                                     //Food = Brie
    "Blue Cheese",                                              //Food = Blue Cheese
    "Gouda",                                                    //Food = Gouda
    "Parmigiano"]                                               //Food = Parmigiano




class FoodDefinitions {
    
    func keywordsforFood(food: Foods) -> [String] {
        switch food {
        case .Beef          : return ["Beef"]
        case .Pork          : return ["Pork"]
        case .Veal          : return ["Veal"]
        case .Lamb          : return ["Lamb"]
        case .Poultry       : return ["Chicken","Turkey"]
        case .Duck          : return ["Duck"]
        case .Salmon        : return ["Salmon"]
        case .WhiteFish     : return ["Basa", "Cod", "Tilapia"]
        case .Tuna          : return ["Tuna"]
        case .Shellfish     : return ["Shrimp", "Oysters", "Mussels","Prawns", "Lobster"]
        case .GoatCheese    : return ["Goat cheese"]
        case .Roquefort     : return ["Roquefort"]
        case .Camembert     : return ["Camembert"]
        case .Brie          : return ["Brie"]
        case .BlueCheese    : return ["Blue Cheese"]
        case .Gouda         : return ["Gouda"]
        case .Parmigiano    : return ["Parmigiano"]
        }
    }
    
}