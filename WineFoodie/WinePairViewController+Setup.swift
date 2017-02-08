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
        } else {
            let alert = UIAlertController(title: "Error", message: "Could not load wine list", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            alert.view.tintColor = kWineFoodie.colors.burgundy
            return
        }
        
        dataManager.delegate = self
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
}
