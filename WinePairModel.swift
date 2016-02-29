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
        
        redWineList = bestMatch(allRed)
        whiteWineList = bestMatch(allWhite)
        roseWineList = bestMatch(allRose)
        sparklingWineList = bestMatch(allSparkling)
        dessertWineList = bestMatch(allDessert)
        
        printPairs(allRed)
        printPairs(redWineList)
    }
    


//MARK: Helpers
    
    func bestMatch(wineList: [WinePair]) -> [WinePair] {
        
        let set = NSCountedSet(array: wineList)
        var maxCount = 0
        var bestMatch = [WinePair]()
        
        for wine in set {
            if (maxCount < set.countForObject(wine)) {
                maxCount = set.countForObject(wine)
                bestMatch.removeAll()
                bestMatch.append(wine as! WinePair)
            }
        }
        return bestMatch
    }
    
    func printPairs(wineList: [WinePair]) {
        for wine in wineList {
            print(wine.country, wine.region, wine.varietal)
        }
    }
    
    /*
    func printPairs(wineTypeList: [String : [WinePair]]) {
        
        for (countryKey,pairsValue) in wineTypeList {
            print(countryKey)
            for pair in pairsValue {
                print(pair.region, pair.varietal)
            }
        }
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
    
    } */

}