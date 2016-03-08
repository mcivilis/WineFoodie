//
//  WinePairViewController+Helpers.swift
//  WineFoodie
//
//  Created by Maria Civilis on 2016-03-08.
//  Copyright © 2016 mcivilis. All rights reserved.
//

import Foundation
import UIKit

extension WinePairViewController {
    
    func formatMatchRanking(matchRanking: Float) -> String {
        let percent = Float(roundf(matchRanking))
        let matchString = percent.description + "%"
        return matchString
    }
    
    func formatWinePrice(price: Int) -> String {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        formatter.locale = NSLocale(localeIdentifier: "en_CA")
        return formatter.stringFromNumber(price / 100)!
    }
    
    func downloadImageForCell(urlString: String, indexPath: NSIndexPath) {
        let url = NSURL(string: urlString)
        let urlRequest = NSURLRequest(URL: url!)
        let dataTask = NSURLSession.sharedSession().dataTaskWithRequest(urlRequest) { (data, response, error) -> Void in
            if error == nil {
                if let imageData = data {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        if let cell = self.tableView.cellForRowAtIndexPath(indexPath) as? WineCell {
                            if (self.tableView.visibleCells.contains(cell) == true) {
                                cell.wineImageView.image = UIImage(data: imageData)
                                cell.wineImageView.contentMode = .ScaleAspectFit
                            }
                        }
                    })
                }
            }
        }
        dataTask.resume()
    }

}
