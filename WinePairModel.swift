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
        
        print("all")
        printPairs(allRed)
        print("best")
        printPairs(redWineList)
    }
    


//MARK: Helpers
    
    func bestMatch(wineList: [WinePair]) -> [WinePair] {
        
        let uniquePairs = Array(Set(wineList))
        var uniquePairsRepeatCount = [Int]()
        //print("uniquePairs = wune paris no dupes -> should be 7")
        //printPairs(uniquePairs)
        
        for _ in uniquePairs {
            uniquePairsRepeatCount.append(0)
        }
        
        for pair in wineList {
            for uniquePair in uniquePairs{
                if (pair == uniquePair) {
                    let index = uniquePairs.indexOf(uniquePair)
                    uniquePairsRepeatCount[index!]++
                }
            }
        }
        //print("uniquePairsRepeatCount = number of times each wine pair repeats, sum should equal 10")
        //print(uniquePairsRepeatCount)
        var ratingCounts = Array(Set(uniquePairsRepeatCount))
        
        ratingCounts.sortInPlace()
        //print("ratingCounts = unique rating as Int")
        //print(ratingCounts)
        
        var ratingArray = [Float]()
        for element in ratingCounts {
            let index = ratingCounts.indexOf(element)! + 1
            let rating = Float(index) * (100 / Float(ratingCounts.count))
            ratingArray.append(rating)
        }
        //print("ratingArray = unique rating as Float")
        //print(ratingArray)
        
        var wineListWithRating = [WinePair]()
        for pair in wineList {
            let pairWithRating = pair 
            let actualCount = uniquePairsRepeatCount[(uniquePairs.indexOf(pair))!]
            let index = ratingCounts.indexOf(actualCount)
            pairWithRating.matchRating = ratingArray[index!]
            wineListWithRating.append(pairWithRating)
        }

        return Array(Set(wineListWithRating))
    }
    
    func printPairs(wineList: [WinePair]) {
        for wine in wineList {
            print(wine.country, wine.varietal, wine.matchRating)
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