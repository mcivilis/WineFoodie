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
        selectCurrentLabel(redLabel)
        self.tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
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

}