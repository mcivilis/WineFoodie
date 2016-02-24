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
    
    func prepareFoodPairingModel(food: Foods) {
        
        var sparklingWineList = [WinePair]()
        var redWineLinst = [WinePair]()
        var whiteWineList = [WinePair]()
        var roseWineList = [WinePair]()
        var desserWineList = [WinePair]()
        
        for wine in wineList {
            
            let winePair = WinePair(wineRegion: wine.region, wineVarietal: wine.varietal)
            
            switch wine.type {
            case "Red Wine"          : redWineLinst.append(winePair)
            case "White Wine"        : whiteWineList.append(winePair)
            case "Rosé Wine"         : roseWineList.append(winePair)
            case "Sparkling Wine"    : sparklingWineList.append(winePair)
            case "Dessert/Fortified" : desserWineList.append(winePair)
            default                  : print("Unexpected wine type found")
            }
        }
        sparklingWineList = Array(Set(sparklingWineList))
        redWineLinst = Array(Set(redWineLinst))
        whiteWineList = Array(Set(whiteWineList))
        roseWineList = Array(Set(roseWineList))
        desserWineList = Array(Set(desserWineList))
        
        for winePair in redWineLinst {                                         //PRINTING
            print(winePair.country, winePair.region, winePair.varietal)        //PRINTING
        }                                                                      //PRINTING
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