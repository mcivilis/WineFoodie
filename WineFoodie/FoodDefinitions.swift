//
//  FoodDefinitions.swift
//  WineFoodie
//
//  Created by Maria Civilis on 2016-02-24.
//  Copyright © 2016 mcivilis. All rights reserved.
//

import Foundation

let sectionNames = ["Meat", "Poultry", "Fish", "Shellfish", "Pasta & Risotto"]

let sectionFoods = [["Beef","Lamb","Pork","Meatloaf","Prosciutto","Ham"],           //Meat
                    ["Chicken","Duck","Turkey"],                                    //Poultry
                    ["Salmon","Tuna","Cod","Tilapia","Catfish"],                    //Fish
                    ["Oyster","Scallops","Shrimp","Mussels","Lobster"],             //Shellfish
                    ["Pesto","Tomato Sauce","Bolognese","Lasagna","Risotto"]]       //Pasta & Risotto

//Recipe search keywords
let foods = ["Beef","Lamb","Pork","Meatloaf","Prosciutto","Ham",
    "Chicken","Duck","Turkey",
    "Salmon","Tuna","Cod","Tilapia","Catfish",
    "Oyster","Scallops","Shrimp","Mussels","Lobster",
    "Pesto","Tomato Sauce","Bolognese","Lasagna","Risotto"]

enum Foods : String {
    //Meat
    case Beef = "Beef"
    case Lamb = "Lamb"
    case Pork = "Pork"
    case Meatloaf = "Meatloaf"
    case Prosciutto = "Prosciutto"
    case Ham = "Ham"
    
    //Poultry
    case Chicken = "Chicken"
    case Duck = "Duck"
    case Turkey = "Turkey"
    
    //Fish
    case Salmon = "Salmon"
    case Tuna = "Tuna"
    case Cod = "Cod"
    case Tilapia = "Tilapia"
    case Catfish = "Catfish"
    
    //Shellfish
    case Oyster = "Oyster"
    case Scallops = "Scallops"
    case Shrimp = "Shrimp"
    case Mussels = "Mussels"
    case Lobster = "Lobster"
    
    //Pasta & Risotto
    case Pesto = "Pesto"
    case TomatoSauce = "Tomato Sauce"
    case Bolognese = "Bolognese"
    case Lasagna = "Lasagna"
    case Risotto = "Risotto"
}

class FoodDefinitions {
        func keywordsforFood(food: Foods) -> [String] {
        return [food.rawValue]
        }
}
    
