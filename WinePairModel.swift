//
//  WinePairModel.swift
//  WineFoodie
//
//  Created by Maria Civilis on 2016-02-26.
//  Copyright © 2016 mcivilis. All rights reserved.
//

import Foundation

class WinePairModel {
    
//    var redWineList : [String : [WinePair]]!
//    var whiteWineList : [String : [WinePair]]!
//    var roseWineList : [String : [WinePair]]!
//    var sparklingWineList : [String : [WinePair]]!
//    var dessertWineList : [String : [WinePair]]!

    var redWineList : [WinePair]!
    var whiteWineList : [WinePair]!
    var roseWineList : [WinePair]!
    var sparklingWineList : [WinePair]!
    var dessertWineList : [WinePair]!
    
    func prepare(wineList: [Wine], foodType: Foods) {
        
        var allSparkling = [WinePair]()
        var allRed = [WinePair]()
        var allWhite = [WinePair]()
        var allRose = [WinePair]()
        var allDessert = [WinePair]()
        var keywordFound = false
        let foodDefinitions = FoodDefinitions()
        
        for wine in wineList {
            
            for keyword in foodDefinitions.keywordsforFood(foodType) {
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
        
        redWineList = allRed
        whiteWineList = allWhite
        roseWineList = allRose
        sparklingWineList = allSparkling
        dessertWineList = allDessert
        
//        redWineList = groupedDictionary(allRed)
//        whiteWineList = groupedDictionary(allWhite)
//        roseWineList = groupedDictionary(allRose)
//        sparklingWineList = groupedDictionary(allSparkling)
//        dessertWineList = groupedDictionary(allDessert)
    }
    
    //MARK: Helper
    
//    func groupedDictionary(allWinePairs: [WinePair]) -> [String : [WinePair]] {
//        
//        var wineListDictionary = [String : [WinePair]]()
//        for winePair in allWinePairs {
//            if wineListDictionary[winePair.country] == nil {
//                wineListDictionary[winePair.country] = []
//            }
//            wineListDictionary[winePair.country]?.append(winePair)
//        }
//        return wineListDictionary
//        
//    }
    
    func printPairs(wineTypeList: [String : [WinePair]]) {
        
        for (countryKey,pairsValue) in wineTypeList {
            print(countryKey)
            for pair in pairsValue {
                print(pair.region, pair.varietal)
            }
        }
    }

}