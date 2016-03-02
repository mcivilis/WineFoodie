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
    
    //MARK: Initial Setup
    
    func prepareProperties() {
        saveLabels()
        selectCurrentLabel(redLabel)
        
        delegate?.didFinishLoading(finishedLoading)
        dataManager.delegate = self
        view.bringSubviewToFront(activityIndicatorView)
        activityIndicatorView.startAnimating()
        
        wines.removeAll()
        sparklingWines.removeAll()
        whiteWines.removeAll()
        roseWines.removeAll()
        redWines.removeAll()
        dessertWines.removeAll()
        
        self.tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func saveLabels() {
        wineTypeLabels = [sparklingLabel, whiteLabel, roseLabel, redLabel, dessertLabel]
    }
    
    func selectCurrentLabel(currentLabel: UILabel) {
        for label in wineTypeLabels {
            label.textColor = kWineFoodieGray
            if (label.isEqual(currentLabel)) {
                label.textColor = kWineFoodieBurgundy
            }
        }
    }
    
    //MARK: Gesture Recognizers
    
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
        selectCurrentLabel(sparklingLabel)
        wines = sparklingWines
        wines.sortInPlace({$0.matchRating > $1.matchRating})
        tableView.reloadData()
        initialView = false
    }
    
    func tapActionWhite() {
        selectCurrentLabel(whiteLabel)
        wines = whiteWines
        wines.sortInPlace({$0.matchRating > $1.matchRating})
        tableView.reloadData()
        initialView = false
    }
    
    func tapActionRose() {
        selectCurrentLabel(roseLabel)
        wines = roseWines
        wines.sortInPlace({$0.matchRating > $1.matchRating})
        tableView.reloadData()
        initialView = false
    }
    
    func tapActionRed() {
        selectCurrentLabel(redLabel)
        wines = redWines
        wines.sortInPlace({$0.matchRating > $1.matchRating})
        tableView.reloadData()
        initialView = false
    }
    
    func tapActionDessert() {
        selectCurrentLabel(dessertLabel)
        wines = dessertWines
        wines.sortInPlace({$0.matchRating > $1.matchRating})
        tableView.reloadData()
        initialView = false
    }
}