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
        let tapGestureWhite = UITapGestureRecognizer(target: self, action: #selector(WinePairViewController.tapActionWhite))
        whiteImage.isUserInteractionEnabled = true
        whiteImage.addGestureRecognizer(tapGestureWhite)
        
        let tapGestureRose = UITapGestureRecognizer(target: self, action: #selector(WinePairViewController.tapActionRose))
        roseImage.isUserInteractionEnabled = true
        roseImage.addGestureRecognizer(tapGestureRose)
        
        let tapGestureRed = UITapGestureRecognizer(target: self, action: #selector(WinePairViewController.tapActionRed))
        redImage.isUserInteractionEnabled = true
        redImage.addGestureRecognizer(tapGestureRed)
        
        let tapGestureDessert = UITapGestureRecognizer(target: self, action: #selector(WinePairViewController.tapActionDessert))
        dessertImage.isUserInteractionEnabled = true
        dessertImage.addGestureRecognizer(tapGestureDessert)
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

