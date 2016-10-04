//
//  Food.swift
//  WineFoodie
//
//  Created by Masha on 2016-08-06.
//  Copyright © 2016 mcivilis. All rights reserved.
//

import Foundation

extension Food : JSONParselable {
    
    static func withJSON(_ json: [String : AnyObject]) -> Food? {
        guard
            let name = string(json, key: "name")
            else {
                return nil
        }
        
        let winePairDicts = json["wine_pairs"] as? [[String:AnyObject]]
        func sanitizedWinePairs(_ dicts: [[String:AnyObject]]?) -> [WinePair] {
            guard let dicts = dicts else {
                return [WinePair]()
            }
            return dicts.flatMap { WinePair.withJSON($0) }
        }
        return Food(name: name, winePairs: sanitizedWinePairs(winePairDicts))
    }
}
