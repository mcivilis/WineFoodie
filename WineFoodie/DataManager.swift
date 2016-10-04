//
//  DataManager.swift
//  WineFoodie
//
//  Created by Maria Civilis on 2016-02-22.
//  Copyright © 2016 mcivilis. All rights reserved.
//

import Foundation

protocol DataManagerProtocol {
    func didUpdateWineList()
}

class DataManager {
    
    var delegate: DataManagerProtocol?
    var wineList = [LCBOWine]()
    
    func loadDataFromURL(_ url: URL, completion:@escaping (_ data: Data?, _ error: NSError?) -> Void) {
        let session = URLSession.shared
        let loadDataTask = session.dataTask(with: url, completionHandler: { (data, response, error) -> Void in
            if let error = error {
                print(error);
                completion(nil, error as NSError?)
            } else {
                completion(data, nil)
            }
        }) 
        loadDataTask.resume()
    }
   
}
