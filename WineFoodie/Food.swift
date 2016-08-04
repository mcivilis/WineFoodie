//
//  Food.swift
//  WineFoodie
//
//  Created by Masha on 2016-08-03.
//  Copyright © 2016 mcivilis. All rights reserved.
//

import Foundation

class Food {
    var name: String?
    var winePairs: [WinePair]?
    
    init(foodName: String, foodWinePairs:[WinePair]) {
        name = foodName
        winePairs = foodWinePairs
    }
}
