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
    
    func saveLabels() {
        wineGroupLabels = [sparklingLabel, whiteLabel, roseLabel, redLabel, dessertLabel]
    }
    
    func selectCurrentLabel(currentLabel: UILabel) {
        for label in wineGroupLabels {
            label.textColor = kWineFoodieGray
            if (label.isEqual(currentLabel)) {
                label.textColor = kWineFoodieBurgundy
            }
        }
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
    
    func wineGroupHasMatch(wineGroup: WineGroup) -> Bool {
        var wineGroupHasMatch = false
        for winePair in winePairs {
            if (winePair.group == wineGroup) {
                wineGroupHasMatch = true
            }
        }
        return wineGroupHasMatch
    }
    
    func alertNoWinePairsFoundForType(wineGroup: WineGroup) {
        let alert = UIAlertController(title: "Sorry, no \(wineGroup.rawValue) pairs found.", message: "Please try one of the other wine types.", preferredStyle: .Alert)
        let ok = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alert.addAction(ok)
        presentViewController(alert, animated: true, completion: nil)
    }

}
