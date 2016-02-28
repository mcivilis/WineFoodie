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
                self.redWines = self.redWines + lcboWineList
                self.wines = self.redWines
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.tableView.reloadData()
                })
            })
        }
        
        for winePair in winePairModel.whiteWineList {
            
            dataManager.lcboWineList(cleanQueryOptions(winePair), completion: { (lcboWineList) -> Void in
                self.whiteWines = self.whiteWines + lcboWineList
            })
        }
        
        for winePair in winePairModel.roseWineList {
            
            dataManager.lcboWineList(cleanQueryOptions(winePair), completion: { (lcboWineList) -> Void in
                self.roseWines = self.roseWines + lcboWineList
            })
        }
        
        for winePair in winePairModel.sparklingWineList {
            
            dataManager.lcboWineList(cleanQueryOptions(winePair), completion: { (lcboWineList) -> Void in
                self.sparklingWines = self.sparklingWines + lcboWineList
            })
        }
        
        for winePair in winePairModel.dessertWineList {
            
            dataManager.lcboWineList(cleanQueryOptions(winePair), completion: { (lcboWineList) -> Void in
                self.dessertWines = self.dessertWines + lcboWineList
            })
        }
    }
    
    func cleanQueryOptions(winePair: WinePair) -> String {
        let charactersToRemove = NSCharacterSet.alphanumericCharacterSet().invertedSet
        let country = winePair.country.componentsSeparatedByCharactersInSet(charactersToRemove).joinWithSeparator(" ")
        let region = winePair.region.componentsSeparatedByCharactersInSet(charactersToRemove).joinWithSeparator(" ")
        let varietal = winePair.varietal.componentsSeparatedByCharactersInSet(charactersToRemove).joinWithSeparator(" ")
        let plus = "+"
        
        return country + plus + region + plus + varietal
    }

}