//
//  searchOptions.swift
//  WineFoodie
//
//  Created by Maria Civilis on 2016-02-23.
//  Copyright © 2016 mcivilis. All rights reserved.
//

import Foundation

//API Search Options

let wineListAPI = "http://api.snooth.com/wines/"
let detailWineAPI = "http://api.snooth.com/wine/"
let apiKey = "?akey=" + "exv5m69z4qivba6bcrroro20p0vxwucryz1xou81qv9vcf21"

let wineListDefaultOptions = "&n=10" + "&s=qpr" //max allowed by API = 100
let wineType = ["&t=wine","&t=dessert","&t=sparkling"]
let wineColor = ["&color=red","&color=white","&color=rose"]

let detailWineOptions = "&food=1"
let detailWineIdCommand = "&id="


//Recipe search keywords

let foods = ["Beef","Pork","Chicken","Turkey","Salmon", "Basa", "Cod", "Tilapia", "Tuna", "Trout", "Shrimp", "Oysters", "Mussels","Prawns", "Lobster", "Veal","Lamb","Duck","Goat Cheese","Roquefort","Camembert","Brie","Blue Cheese","Gouda","Parmigiano"]
