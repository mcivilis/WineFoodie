//
//  FoodDefinitions.swift
//  WineFoodie
//
//  Created by Maria Civilis on 2016-02-24.
//  Copyright © 2016 mcivilis. All rights reserved.
//

import Foundation

let groupedFoods = [
    "Meat": ["Beef","Lamb","Pork","Meatloaf","Prosciutto","Ham"],
    "Poultry": ["Chicken","Duck","Turkey"],
    "Shellfish": ["Oyster","Scallops","Shrimp","Mussels","Lobster"],
    "Fish": ["Salmon","Tuna","Cod","Tilapia","Catfish"],
    "Pasta & Risotto": ["Pesto","Tomato Sauce","Bolognese","Lasagna","Risotto"]
]

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

//Recipe search keywords

let foods = [
        "Salmon",
        "Tuna",
        "Cod",
        "Tilapia",
        "Catfish",
        "Beef",
        "Lamb",
        "Pork",
        "Meatloaf",
        "Prosciutto",
        "Ham",
        "Chicken",
        "Duck",
        "Turkey",
        "Pesto",
        "Tomato Sauce",
        "Bolognese",
        "Lasagna",
        "Risotto",
        "Oyster",
        "Scallops",
        "Shrimp",
        "Mussels",
        "Lobster"]

class FoodDefinitions {
        func keywordsforFood(food: Foods) -> [String] {
        return [food.rawValue]
        }
}
    
