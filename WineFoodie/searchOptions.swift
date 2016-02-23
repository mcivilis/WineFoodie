//
//  searchOptions.swift
//  WineFoodie
//
//  Created by Maria Civilis on 2016-02-23.
//  Copyright © 2016 mcivilis. All rights reserved.
//

import Foundation

let wineListAPI = "http://api.snooth.com/wines/"
let detailWineAPI = "http://api.snooth.com/wine/"
let apiKey = "?akey=" + "exv5m69z4qivba6bcrroro20p0vxwucryz1xou81qv9vcf21"

let wineListDefaultOptions = "&n=100" + "&s=qpr"
let wineType = ["&t=wine","&t=dessert","&t=sparkling"]
let wineColor = ["&color=red","&color=white","&color=rose"]

let detailWineOptions = "&food=1"
let detailWineIdCommand = "&id="

