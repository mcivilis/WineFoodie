//
//  DataManager+Helpers.swift
//  WineFoodie
//
//  Created by Maria Civilis on 2016-03-08.
//  Copyright © 2016 mcivilis. All rights reserved.
//

import Foundation

extension DataManager {
    
    func prepareWinePairString(winePair: WinePair) -> String {
        let charactersToRemove = NSCharacterSet.alphanumericCharacterSet().invertedSet
        let wineGroup = winePair.group.rawValue
        let group = wineGroup.componentsSeparatedByCharactersInSet(charactersToRemove).joinWithSeparator(" ")
        let varietal = winePair.varietal.componentsSeparatedByCharactersInSet(charactersToRemove).joinWithSeparator(" ")
        let country = winePair.country.componentsSeparatedByCharactersInSet(charactersToRemove).joinWithSeparator(" ")
        let plus = "+"
        return group + plus + varietal + plus + country
    }

}
