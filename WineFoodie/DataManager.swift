//
//  DataManager.swift
//  WineFoodie
//
//  Created by Maria Civilis on 2016-02-22.
//  Copyright © 2016 mcivilis. All rights reserved.
//

import Foundation

protocol DataManagerDelegate : class {
    func didUpdateWineListWithOptions(optionsUpdated: Int)
    func didUpdateRecepes(recipesUpdated: Int)
}

class DataManager {
    
    var wineList : [Wine]!
    var delegate : DataManagerDelegate?
    
    var redWineList : [String : [WinePair]]!
    var whiteWineList : [String : [WinePair]]!
    var roseWineList : [String : [WinePair]]!
    var sparklingWineList : [String : [WinePair]]!
    var dessertWineList : [String : [WinePair]]!
    
    func prepareFoodPairingModel(food: Foods) {
        
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
        
        for red in allRed {
            print(red.country,"+",red.region,"+",red.varietal)
        }
        
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
    
    func loadRecipes() {
        
        var callCount = 0
        
        for wine in self.wineList {
            recipes(wine.code, completion: { (recipeList) -> Void in
                callCount++
                wine.recipes = recipeList
                wine.foods = self.pairFood(recipeList)
                print(callCount) //REMOVE PRINTING
                self.delegate!.didUpdateRecepes(callCount)
            })
        }
    }
    
    func pairFood (recipeList: [Recipe]) -> [String] {
        
        var foodPairing = [String]()
        for recipe in recipeList {
            for food in foods {
                if recipe.name.rangeOfString(food) != nil {
                    foodPairing.append(food)
                }
            }
        }
        return Array(Set(foodPairing))
    }
    
    func loadWines() {
        
        let options = queryOptions()
        var callCount = 0
        
        for option in options {
            wineList(option) { (wineList) -> Void in
                callCount++
                if self.wineList == nil {
                    self.wineList = wineList
                } else {
                    self.wineList = self.wineList + wineList
                }
                self.delegate!.didUpdateWineListWithOptions(callCount)
            }
        }
    }
    
    func queryOptions() -> [String] {
        
        var options = [String]()
        for colorOption in wineColor {
            for typeOption in wineType {
                options.append(colorOption + typeOption)
            }
        }
        return options
    }
    
   
}