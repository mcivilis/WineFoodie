//
//  WinePairingModel.swift
//  WineFoodie
//
//  Created by Maria Civilis on 2016-02-26.
//  Copyright © 2016 mcivilis. All rights reserved.
//

import Foundation

class WinePairingModel {
    
    var redWineList : [String : [WinePair]]!
    var whiteWineList : [String : [WinePair]]!
    var roseWineList : [String : [WinePair]]!
    var sparklingWineList : [String : [WinePair]]!
    var dessertWineList : [String : [WinePair]]!
    
    func prepareFoodPairingModel(wineList: [Wine], food: Foods) {
        
        var allSparkling = [WinePair]()
        var allRed = [WinePair]()
        var allWhite = [WinePair]()
        var allRose = [WinePair]()
        var allDessert = [WinePair]()
        var keywordFound = false
        let foodDefinitions = FoodDefinitions()
        
        for wine in wineList {
            
            for keyword in foodDefinitions.keywordsforFood(food) {
                for recipe in wine.recipes! {
                    if recipe.name.rangeOfString(keyword) != nil {
                        keywordFound = true
                    }
                }
            }
            if keywordFound {
                let winePair = WinePair(wineRegion: wine.region, wineVarietal: wine.varietal)
                switch wine.type {
                case "Red Wine"          : allRed.append(winePair)
                case "White Wine"        : allWhite.append(winePair)
                case "Rosé Wine"         : allRose.append(winePair)
                case "Sparkling Wine"    : allSparkling.append(winePair)
                case "Dessert/Fortified" : allDessert.append(winePair)
                default                  : print("Unexpected wine type found")
                }
            }
        }
        
        allRed = Array(Set(allRed))
        allWhite = Array(Set(allWhite))
        allRose = Array(Set(allRose))
        allSparkling = Array(Set(allSparkling))
        allDessert = Array(Set(allDessert))
        
        redWineList = groupedDictionary(allRed)
        whiteWineList = groupedDictionary(allWhite)
        roseWineList = groupedDictionary(allRose)
        sparklingWineList = groupedDictionary(allSparkling)
        dessertWineList = groupedDictionary(allDessert)
    }
    
    func groupedDictionary(allWinePairs: [WinePair]) -> [String : [WinePair]] {
        
        var wineListDictionary = [String : [WinePair]]()
        for winePair in allWinePairs {
            if wineListDictionary[winePair.country] == nil {
                wineListDictionary[winePair.country] = []
            }
            wineListDictionary[winePair.country]?.append(winePair)
        }
        return wineListDictionary
        
    }
}