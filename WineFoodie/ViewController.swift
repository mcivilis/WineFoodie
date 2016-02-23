//
//  ViewController.swift
//  WineFoodie
//
//  Created by Maria Civilis on 2016-02-22.
//  Copyright © 2016 mcivilis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
        let domainPlusKey = "http://api.snooth.com/wines/?akey=exv5m69z4qivba6bcrroro20p0vxwucryz1xou81qv9vcf21"
        let url = NSURL(string: domainPlusKey + "&food=1")
        
        DataManager().loadDataFromURL(url!) { (data, error) -> Void in
            
            guard error != nil else {
                return
            }
            
            typealias WinePayload = [String: AnyObject]
            var json: WinePayload!
            
            do {
                json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions()) as? WinePayload
                
            } catch {
                print("error")
                return
            }
            
            guard let wines = json["wines"] as? [Wine]
                else {
                    print("No wines found")
                    return
            }
            
            for wine in wines {
                print(wine.name)
            }
            
            var wineList : [Wine]!
            
            typealias RecipePayload = [Recipe]
            var recipes: RecipePayload
            
            for wine in wines {
                
                guard let recipes = wine["recipes"] as? [RecipePayload]
                    else {
                        print("No recipes found")
                        return
                }
                
//                guard let recipes = wine["recipes"] as? recipePayload
//                    else {
//                        print("recipes not saved")
//                        return
//                }
                
                if let name = wine["name"] as? String,
                    let code = wine["code"] as? String,
                    let varietal = wine["varietal"] as? String,
                    let vintage = wine["vintage"] as? String,
                    let wineType = wine["type"] as? String,
                    let region = wine["region"] as? String,
                    let snoothrank = wine["snoothrank"] as? Int,
                    let price = wine["price"] as? Int {
                        
                        let addWine = Wine(
                            name: wine["name"] as! String,
                            code: wine["code"] as! String,
                            varietal: wine["varietal"] as! String,
                            vintage: wine["vintage"] as! String,
                            wineType: wine["type"] as! String,
                            region: wine["region"] as! String,
                            snoothrank: wine["snoothrank"] as! Int,
                            price: wine["price"] as! Int,
                            recipes: recipes)
                        
                        wineList.append(addWine)
                }
            }
            
            print("test")
            let printWine = wineList[0] 
            print(printWine)
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

