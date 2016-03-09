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
        dataManager = DataManager()
        dataManager.delegate = self
        dataManager.closestStoreID = self.closestStoreID
        view.bringSubviewToFront(activityIndicatorView)
        activityIndicatorView.startAnimating()
        
        for winePair in winePairs {
            if (winePair.group == currentWineGroup) {
                dataManager.lcboWineList(winePair)
            }
        }
    }

}