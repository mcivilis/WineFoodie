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
    
    func selectCurrentLabel(_ currentLabel: UILabel) {
        for label in wineGroupLabels {
            label.textColor = kWineFoodie.colors.gray
            if (label.isEqual(currentLabel)) {
                label.textColor = kWineFoodie.colors.burgundy
            }
        }
    }
    
    func formatWinePrice(_ price: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.currency
        formatter.locale = Locale(identifier: "en_CA")
        return formatter.string(from: divide(num1: price, num2: 100))!
    }
    
    func divide(num1: Int, num2: Int) -> NSNumber {
        return NSNumber.init(value: (Double(num1) / Double(num2)))
    }
    
    func downloadImageForCell(_ urlString: String, indexPath: IndexPath) {
        let url = URL(string: urlString)
        let urlRequest = URLRequest(url: url!)
        let dataTask = URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) -> Void in
            if error == nil {
                if let imageData = data {
                    DispatchQueue.main.async(execute: { () -> Void in
                        if let cell = self.tableView.cellForRow(at: indexPath) as? WineCell {
                            if (self.tableView.visibleCells.contains(cell) == true) {
                                cell.wineImageView.image = UIImage(data: imageData)
                                cell.wineImageView.contentMode = .scaleAspectFit
                            }
                        }
                    })
                }
            }
        }) 
        dataTask.resume()
    }
    
    func wineGroupHasMatch(_ wineGroup: WineGroup) -> Bool {
        var wineGroupHasMatch = false
        for winePair in winePairs {
            if (winePair.group == wineGroup) {
                wineGroupHasMatch = true
            }
        }
        return wineGroupHasMatch
    }
    
    func alertNoWinePairsFoundForType(_ wineGroup: WineGroup) {
        let alert = UIAlertController(title: "Sorry, no \(wineGroup.rawValue) pairs found.", message: "Please try one of the other wine types.", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
        alert.view.tintColor = kWineFoodie.colors.burgundy
    }
    
    func updateImages() -> Void {
        
        if (self.wineGroupHasMatch(.Red)) {
            self.redImage.image = UIImage.init(named: "red.png")
        } else {
            self.redImage.image = UIImage.init(named: "red_bw.png")
        }
        if (self.wineGroupHasMatch(.White)) {
            self.whiteImage.image = UIImage.init(named: "white.png")
        } else {
            self.whiteImage.image = UIImage.init(named: "white_bw.png")
        }
        if (self.wineGroupHasMatch(.Rose)) {
            self.roseImage.image = UIImage.init(named: "rose.jpg")
        } else {
            self.roseImage.image = UIImage.init(named: "rose_bw.jpg")
        }
        if (self.wineGroupHasMatch(.Sparkling)) {
            self.sparklingImage.image = UIImage.init(named: "sparkling.png")
        } else {
            self.sparklingImage.image = UIImage.init(named: "sparkling_bw.png")
        }
        if (self.wineGroupHasMatch(.Dessert)) {
            self.dessertImage.image = UIImage.init(named: "dessert.jpg")
        } else {
            self.dessertImage.image = UIImage.init(named: "dessert_bw.jpg")
        }
        self.redImage.setNeedsLayout()
        self.whiteImage.setNeedsLayout()
        self.roseImage.setNeedsLayout()
        self.dessertImage.setNeedsLayout()
        self.sparklingImage.setNeedsLayout()
    }

}
