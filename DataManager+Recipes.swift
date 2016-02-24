//
//  DataManager+Recipes.swift
//  WineFoodie
//
//  Created by Maria Civilis on 2016-02-23.
//  Copyright © 2016 mcivilis. All rights reserved.
//

import Foundation

extension DataManager {
    
    func recipes(wineCode: String, completion: (recipeList: [Recipe]) -> Void) {
        
        let detailWineListURL = NSURL(string: detailWineAPI + apiKey + detailWineIdCommand + wineCode + detailWineOptions)
        
        
        loadDataFromURL(detailWineListURL!) { (data, error) -> Void in
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
                }
            }
            completion(recipeList: recipeList)
        }
    }

}
