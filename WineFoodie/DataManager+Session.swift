//
//  DataManager+Session.swift
//  WineFoodie
//
//  Created by Maria Civilis on 2016-02-23.
//  Copyright © 2016 mcivilis. All rights reserved.
//

import Foundation

extension DataManager {
    
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