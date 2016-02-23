//
//  DataManager.swift
//  WineFoodie
//
//  Created by Maria Civilis on 2016-02-22.
//  Copyright © 2016 mcivilis. All rights reserved.
//

import Foundation

class DataManager {
    
    let wineListAPI = "http://api.snooth.com/wines/"
    let detailWineAPI = "http://api.snooth.com/wine/"
    let apiKey = "?akey=" + "exv5m69z4qivba6bcrroro20p0vxwucryz1xou81qv9vcf21"

    let wineListOptions = "&q=wine"
    let detailWineOptions = "&food=1"
    let detailWineIdCommand = "&id="
    
    func loadDataFromURL(url: NSURL, completion:(data: NSData?, error: NSError?) -> Void) {
        let session = NSURLSession.sharedSession()
        let loadDataTask = session.dataTaskWithURL(url) { (data, response, error) -> Void in
            if let error = error {
                print(error);
                completion(data: nil, error: error)
            } else {
                completion(data: data, error: nil)
            }
        }
        loadDataTask.resume()
    }
}