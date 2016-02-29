//
//  searchOptions.swift
//  WineFoodie
//
//  Created by Maria Civilis on 2016-02-23.
//  Copyright © 2016 mcivilis. All rights reserved.
//

import Foundation

//Snooth API Options
//recipes url : detailWineAPI + snoothAPIKey + detailWineIdCommand + wineCode + detailWineOptions
//wines url   : wineListAPI + snoothAPIKey + wineListDefaultOptions + <query parameters>

let wineListAPI = "http://api.snooth.com/wines/"
let detailWineAPI = "http://api.snooth.com/wine/"
let snoothAPIKey = "?akey=" + "exv5m69z4qivba6bcrroro20p0vxwucryz1xou81qv9vcf21"

let wineListDefaultOptions = "&n=10" + "&s=qpr" //max n = 100
let wineType = ["&t=wine","&t=dessert","&t=sparkling"]
let wineColor = ["&color=red","&color=white","&color=rose"]

let detailWineOptions = "&food=1"
let detailWineIdCommand = "&id="


//LCBO API Options
//lcbo url : lcboProductsAPI + lcboQueryParameters + lcboAPIKey + lcboSort + lcboQueryCommand + <query parameters>
let lcboProductsAPI = "http://lcboapi.com/products"
let lcboQueryParameters = "?per_page=100?where_not=is_dead" //max page = 100
let lcboAPIKey = "?access_key=" + "MDpkZTFhZmYyNi1kOThlLTExZTUtYmZiNy02M2I1YzUwOTAwNjI6WUpVd0xQckJEVVdEWDBLVGJNeWFTZkpUOXVRQmhTU2x6WDMw"
let lcboSort = "&store_id=10" + "&order=inventory_count"
let lcboQueryCommand = "&q="
