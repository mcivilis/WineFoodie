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
       
        
        let url = NSURL(string: "http://api.snooth.com/wines/?akey=exv5m69z4qivba6bcrroro20p0vxwucryz1xou81qv9vcf21&food=1")
        
        DataManager().loadDataFromURL(url!) { (data, error) -> Void in
            
            print(data)
            guard error != nil else {
                print(error)
                return
            }
            
            typealias winePayload = [String: AnyObject]
            var json: winePayload!
            
            do {
                json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions()) as? winePayload
                
            } catch {
                print(error)
                return
            }
            
            guard let wines = json["wines"] as? [AnyObject]
                else {
                    print("No wines found")
                    return
            }
            
            var wineList : [Wine]!
            
            typealias recipePayload = [Recipe]
            var recipes: recipePayload
            
            for wine in wines {
                
                guard let recipes = wine["recipes"] as? recipePayload
                    else {
                        return
                }
                
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

