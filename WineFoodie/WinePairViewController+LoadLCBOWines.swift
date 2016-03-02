//
//  WinePairViewController+LoadLCBOWines.swift
//  WineFoodie
//
//  Created by Maria Civilis on 2016-02-28.
//  Copyright © 2016 mcivilis. All rights reserved.
//

import Foundation


extension WinePairViewController {
    
    func loadLCBOData() {
        
        for winePair in winePairModel.redWineList {
            
            dataManager.lcboWineList(cleanQueryOptions(winePair), completion: { (lcboWineList) -> Void in
                var lcboWineListWithRating = [LCBOWine]()
                for wine in lcboWineList {
                    if (wine.secondaryCategory == "Red Wine") {
                    var wineWithRating = wine
                    wineWithRating.matchRating = winePair.matchRating
                    lcboWineListWithRating.append(wineWithRating)
                    }
                }
                self.redWines = self.redWines + lcboWineListWithRating
                self.wines = self.redWines
                self.wines.sortInPlace({$0.matchRating > $1.matchRating})
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.tableView.reloadData()
                    self.redActivity.stopAnimating()
                })
            })
        }
        
        for winePair in winePairModel.whiteWineList {
            
            dataManager.lcboWineList(cleanQueryOptions(winePair), completion: { (lcboWineList) -> Void in
                var lcboWineListWithRating = [LCBOWine]()
                for wine in lcboWineList {
                    if (wine.secondaryCategory == "White Wine") {
                    var wineWithRating = wine
                    wineWithRating.matchRating = winePair.matchRating
                    lcboWineListWithRating.append(wineWithRating)
                    }
                }
                self.whiteWines = self.whiteWines + lcboWineListWithRating
                self.whiteWines.sortInPlace({$0.matchRating > $1.matchRating})
            })
        }
        
        for winePair in winePairModel.roseWineList {
            
            dataManager.lcboWineList(cleanQueryOptions(winePair), completion: { (lcboWineList) -> Void in
                var lcboWineListWithRating = [LCBOWine]()
                for wine in lcboWineList {
                    if (wine.secondaryCategory == "Rosé Wine") {
                    var wineWithRating = wine
                    wineWithRating.matchRating = winePair.matchRating
                    lcboWineListWithRating.append(wineWithRating)
                    }
                }
                self.roseWines = self.roseWines + lcboWineListWithRating
                self.roseWines.sortInPlace({$0.matchRating > $1.matchRating})
            })
        }
        
        for winePair in winePairModel.sparklingWineList {
            
            dataManager.lcboWineList(cleanQueryOptions(winePair), completion: { (lcboWineList) -> Void in
                var lcboWineListWithRating = [LCBOWine]()
                for wine in lcboWineList {
                    if (wine.secondaryCategory == "Sparkling Wine") {
                    var wineWithRating = wine
                    wineWithRating.matchRating = winePair.matchRating
                    lcboWineListWithRating.append(wineWithRating)
                    }
                }
                self.sparklingWines = self.sparklingWines + lcboWineListWithRating
                self.sparklingWines.sortInPlace({$0.matchRating > $1.matchRating})
            })
        }
        
        for winePair in winePairModel.dessertWineList {
            
            dataManager.lcboWineList(cleanQueryOptions(winePair), completion: { (lcboWineList) -> Void in
                var lcboWineListWithRating = [LCBOWine]()
                for wine in lcboWineList {
                    if (wine.secondaryCategory == "Dessert Wine") {
                    var wineWithRating = wine
                    wineWithRating.matchRating = winePair.matchRating
                    lcboWineListWithRating.append(wineWithRating)
                    }
                }
                self.dessertWines = self.dessertWines + lcboWineListWithRating
                self.dessertWines.sortInPlace({$0.matchRating > $1.matchRating})
            })
        }
    }
    
    
    func cleanQueryOptions(winePair: WinePair) -> String {
        let charactersToRemove = NSCharacterSet.alphanumericCharacterSet().invertedSet
        let country = winePair.country.componentsSeparatedByCharactersInSet(charactersToRemove).joinWithSeparator(" ")
        //let region = winePair.region.componentsSeparatedByCharactersInSet(charactersToRemove).joinWithSeparator(" ")
        let varietal = winePair.varietal.componentsSeparatedByCharactersInSet(charactersToRemove).joinWithSeparator(" ")
        let plus = "+"
        
        //return country + plus + region + plus + varietal
        return country + plus + varietal
    }

}