//
//  DataManager.swift
//  WineFoodie
//
//  Created by Maria Civilis on 2016-02-22.
//  Copyright © 2016 mcivilis. All rights reserved.
//

import Foundation

class DataManager {
    
    func loadDataFromURL(url: NSURL, completion:(data: NSData?, error: NSError?) -> Void) {
        let session = NSURLSession.sharedSession()
        let loadDataTask = session.dataTaskWithURL(url) { (data, response, error) -> Void in
            print("completed")
            if let error = error {
                print("error");
                completion(data: nil, error: error)
            } else {
                print("no error");
                completion(data: data, error: nil)
            }
        }
        print("resuming")
        loadDataTask.resume()
    }
}