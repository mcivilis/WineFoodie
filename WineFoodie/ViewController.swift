//
//  ViewController.swift
//  WineFoodie
//
//  Created by Maria Civilis on 2016-02-22.
//  Copyright © 2016 mcivilis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var wineList = [Wine]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for color in wineColor {
            DataManager().wineList(color) { (wineList) -> Void in
                self.wineList = self.wineList + wineList
                print("Number of wines in the list is:", self.wineList.count)
            }
        }
        
        for type in wineType {
            DataManager().wineList(type) { (wineList) -> Void in
                self.wineList = self.wineList + wineList
                print("Number of wines in the list is:", self.wineList.count)
            }
        }
        
        for wine in wineList {
            
            DataManager().detailWineRecipes(wine.code) { (recipeList) -> Void in
                wine.recipes = recipeList
            }
        }
        
        
        
    }
}



/*
        //let winesPlusKey = "http://api.snooth.com/wines/?akey=exv5m69z4qivba6bcrroro20p0vxwucryz1xou81qv9vcf21"
        let winesDetailPlusKey = "http://api.snooth.com/wine/?akey=exv5m69z4qivba6bcrroro20p0vxwucryz1xou81qv9vcf21&id="
        let wineCode = "conway-deep-sea-chardonnay-la-costa-wine-co-2008-1"
        //let winesURL = NSURL(string: winesPlusKey + "&q=wine")
        let wineDetailURL = NSURL(string: winesDetailPlusKey + wineCode + "&food=1")
        
        DataManager().loadDataFromURL(wineDetailURL!) { (data, error) -> Void in
            guard error == nil else {
                print(error)
                return
            }
            
            typealias Payload = [String: AnyObject]
            var json: Payload!
            
            do {
                json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions()) as? Payload
            } catch {
                print(error)
                return
            }
            
            guard let wines = json["wines"] as? [Payload]
                else {
                    print("No recipes found")
                    return
            }
            
            let wineDetail = wines.first;
            
            var recipeList = [Recipe]()
            
            if let recipes = wineDetail!["recipes"] as? [Payload] {
                
                for recipe in recipes {
                    
                    if let recipeName = recipe["name"] as? String {
                        var newRecipe = Recipe(recipeName: recipeName)
                        newRecipe.link = recipe["link"] as? String
                        newRecipe.sourceLink = recipe["source_link"] as? String
                        newRecipe.sourceID = recipe["source_id"] as? String
                        newRecipe.image = recipe["image"] as? String
                        
                        recipeList.append(newRecipe)
            
                        
                    }
                   
//                    if let _ = recipe["name"] as? String,
//                       let _ = recipe["link"] as? String,
//                       let _ = recipe["source_link"] as? String,
//                       let _ = recipe["source_id"] as? String,
//                       let _ = recipe["image"] as? String {
//                        
//                       let newRecipe = Recipe(
//                            name: recipe["name"] as! String,
//                            link: recipe["link"] as! String,
//                            sourceLink: recipe["source_link"] as! String,
//                            sourceID: recipe["source_id"] as! String,
//                            image: recipe["image"] as! String)
//                        
//                        recipeList.append(newRecipe)
//                    }
                }
            }
            //print(recipeList[0])
        }
        
        
        
        
        
        
    }
}

        
//        DataManager().loadDataFromURL(winesURL!) { (data, error) -> Void in
//            
//            guard error != nil else {
//                return
//            }
//            
//            typealias WinePayload = [String: AnyObject]
//            var jsonWines: WinePayload!
//            
//            do {
//                jsonWines = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions()) as? WinePayload
//                
//            } catch {
//                print(error)
//                return
//            }
//            
//            guard let wines = jsonWines["wines"] as? [Wine]
//                else {
//                    print("No wines found")
//                    return
//            }
//            
//            for wine in wines {
//                print(wine.name)
//            }
//            
//            var wineList : [Wine]!
//            
//            typealias RecipePayload = [Recipe]
//            var recipes: RecipePayload
//            
//            for wine in wines {
//                
//                guard let recipes = wine["recipes"] as? [RecipePayload]
//                    else {
//                        print("No recipes found")
//                        return
//                }
//                
////                guard let recipes = wine["recipes"] as? recipePayload
////                    else {
////                        print("recipes not saved")
////                        return
////                }
//                
//                if let name = wine["name"] as? String,
//                    let code = wine["code"] as? String,
//                    let varietal = wine["varietal"] as? String,
//                    let vintage = wine["vintage"] as? String,
//                    let wineType = wine["type"] as? String,
//                    let region = wine["region"] as? String,
//                    let snoothrank = wine["snoothrank"] as? Int,
//                    let price = wine["price"] as? Int {
//                        
//                        let addWine = Wine(
//                            name: wine["name"] as! String,
//                            code: wine["code"] as! String,
//                            varietal: wine["varietal"] as! String,
//                            vintage: wine["vintage"] as! String,
//                            wineType: wine["type"] as! String,
//                            region: wine["region"] as! String,
//                            snoothrank: wine["snoothrank"] as! Int,
//                            price: wine["price"] as! Int,
//                            recipes: recipes)
//                        
//                        wineList.append(addWine)
//                }
//            }
//            
//            print("test")
//            let printWine = wineList[0] 
//            print(printWine)
//            
//        }
//        
//    }
//
//   
//
//
//}

*/