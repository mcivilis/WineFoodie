//
//  WinePairViewController+Setup.swift
//  WineFoodie
//
//  Created by Maria Civilis on 2016-02-28.
//  Copyright © 2016 mcivilis. All rights reserved.
//

import Foundation
import UIKit

extension WinePairViewController {
    
    func setup() {
        saveLabels()
        
        if (self.wineGroupHasMatch(.Red)) {
            selectCurrentLabel(redLabel)
            self.currentWineGroup = .Red
        } else if (self.wineGroupHasMatch(.White)) {
            selectCurrentLabel(whiteLabel)
            self.currentWineGroup = .White
        } else if (self.wineGroupHasMatch(.Rose)) {
            selectCurrentLabel(roseLabel)
            self.currentWineGroup = .Rose
        } else if (self.wineGroupHasMatch(.Dessert)) {
            selectCurrentLabel(dessertLabel)
            self.currentWineGroup = .Dessert
        } else if (self.wineGroupHasMatch(.Sparkling)) {
            selectCurrentLabel(sparklingLabel)
            self.currentWineGroup = .Sparkling
        } else {
            let alert = UIAlertController(title: "Error", message: "Could not load wine list", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            alert.view.tintColor = kWineFoodie.colors.burgundy
        }
        
        dataManager.delegate = self
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        
        if (!self.wineGroupHasMatch(.Red)) {
            self.redImage.image = UIImage.init(named: "red_bw")
        }
        if (!self.wineGroupHasMatch(.White)) {
            self.redImage.image = UIImage.init(named: "white_bw.png")
        }
        if (!self.wineGroupHasMatch(.Rose)) {
            self.redImage.image = UIImage.init(named: "rose_bw.png")
        }
        if (!self.wineGroupHasMatch(.Sparkling)) {
            self.redImage.image = UIImage.init(named: "sparkling_bw.png")
        }
        if (!self.wineGroupHasMatch(.Dessert)) {
            self.redImage.image = UIImage.init(named: "dessert_bw.png")
        }
    }

}
