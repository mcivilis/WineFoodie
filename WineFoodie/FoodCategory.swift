//
//  FoodCategory.swift
//  WineFoodie
//
//  Created by Masha on 2016-08-03.
//  Copyright © 2016 mcivilis. All rights reserved.
//

import Foundation

class FoodCategory: NSObject {
    var name: String?
    var foods: [Food]?
    
    init(catetgoryName: String, categoryFoods:[Food]) {
        name = catetgoryName
        foods = categoryFoods
    }
}
