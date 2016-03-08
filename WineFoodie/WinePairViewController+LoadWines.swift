//
//  WinePairViewController+LoadWines.swift
//  WineFoodie
//
//  Created by Maria Civilis on 2016-03-08.
//  Copyright © 2016 mcivilis. All rights reserved.
//

import Foundation

extension WinePairViewController {
    
    func loadWines() {
        wines = [LCBOWine]()
        view.bringSubviewToFront(activityIndicatorView)
        activityIndicatorView.startAnimating()
        
        for winePair in winePairs {
            if (winePair.group == currentWineGroup) {
                dataManager.lcboWineList(winePair, completion: { (lcboWineList) -> Void in
                    if let wines = self.wines {
                        self.wines = wines + lcboWineList
                    } else {
                        self.wines = lcboWineList
                    }
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        if (self.activityIndicatorView.isAnimating()) {
                            self.activityIndicatorView.stopAnimating()
                        }
                        self.tableView.reloadData()
                        self.sortByMatchRating()
                    })
                })
            }
        }
    }
    
}