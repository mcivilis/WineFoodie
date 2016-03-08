//
//  WinePairViewController+Gestures.swift
//  WineFoodie
//
//  Created by Maria Civilis on 2016-03-04.
//  Copyright © 2016 mcivilis. All rights reserved.
//

import Foundation
import UIKit

extension WinePairViewController {
    
    func configureGestures() {
        let tapGestureSparkling = UITapGestureRecognizer(target:self, action:Selector("tapActionSparkling"))
        sparklingImage.userInteractionEnabled = true
        sparklingImage.addGestureRecognizer(tapGestureSparkling)
        
        let tapGestureWhite = UITapGestureRecognizer(target: self, action: Selector("tapActionWhite"))
        whiteImage.userInteractionEnabled = true
        whiteImage.addGestureRecognizer(tapGestureWhite)
        
        let tapGestureRose = UITapGestureRecognizer(target: self, action: Selector("tapActionRose"))
        roseImage.userInteractionEnabled = true
        roseImage.addGestureRecognizer(tapGestureRose)
        
        let tapGestureRed = UITapGestureRecognizer(target: self, action: Selector("tapActionRed"))
        redImage.userInteractionEnabled = true
        redImage.addGestureRecognizer(tapGestureRed)
        
        let tapGestureDessert = UITapGestureRecognizer(target: self, action: Selector("tapActionDessert"))
        dessertImage.userInteractionEnabled = true
        dessertImage.addGestureRecognizer(tapGestureDessert)
    }
    
    func tapActionSparkling() {
        if (wineGroupHasMatch(.Sparkling)) {
        selectCurrentLabel(sparklingLabel)
        currentWineGroup = .Sparkling
        loadWines()
        } else {
            alertNoWinePairsFoundForType(.Sparkling)
        }
    }
    
    func tapActionWhite() {
        if (wineGroupHasMatch(.White)) {
            selectCurrentLabel(whiteLabel)
            currentWineGroup = .White
            loadWines()
        } else {
            alertNoWinePairsFoundForType(.White)
        }
    }
    
    func tapActionRose() {
        if (wineGroupHasMatch(.Rose)) {
            selectCurrentLabel(roseLabel)
            currentWineGroup = .Rose
            loadWines()
        } else {
            alertNoWinePairsFoundForType(.Rose)
        }
    }
    
    func tapActionRed() {
        if (wineGroupHasMatch(.Red)) {
            selectCurrentLabel(redLabel)
            currentWineGroup = .Red
            loadWines()
        } else {
            alertNoWinePairsFoundForType(.Red)
        }
    }
    
    func tapActionDessert() {
        if (wineGroupHasMatch(.Dessert)) {
            selectCurrentLabel(dessertLabel)
            currentWineGroup = .Dessert
            loadWines()
        } else {
            alertNoWinePairsFoundForType(.Dessert)
        }
    }
    
}

