//
//  DataManager+WineList.swift
//  WineFoodie
//
//  Created by Maria Civilis on 2016-02-23.
//  Copyright © 2016 mcivilis. All rights reserved.
//

import Foundation

extension DataManager {
    
    func wineList (wineOptions: String, completion: (wineList: [Wine]) -> Void) {
        
        let wineListURL = NSURL(string: wineListAPI + snoothAPIKey + wineListDefaultOptions + wineOptions)
        
        loadDataFromURL(wineListURL!) { (data, error) -> Void in
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
                    print("No wines found")
                    return
            }
            
            var wineList = [Wine]()
            
            for wine in wines {
                if let code = wine["code"] as? String,
                    let region = wine["region"] as? String,
                    let varietal = wine["varietal"] as? String,
                    let type = wine["type"] as? String {
                        let newWine = Wine(wineCode: code, wineRegion: region, wineVarietal:varietal, wineType:type)
                        wineList.append(newWine)
                }
            }
            completion(wineList: wineList)
        }
    }
}
