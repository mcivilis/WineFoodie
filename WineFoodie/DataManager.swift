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
    
    func loadRecipes() {
        
        var callCount = 0
        
        for wine in self.wineList {
            recipes(wine.code, completion: { (recipeList) -> Void in
                callCount++
                wine.recipes = recipeList
                self.delegate!.didUpdateRecepes(callCount)
                print(callCount)
            })
        }
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