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
        wines = sparklingWines
        wines.sortInPlace({$0.matchRating > $1.matchRating})
        tableView.reloadData()
    }
    
    func tapActionWhite() {
        wines = whiteWines
        wines.sortInPlace({$0.matchRating > $1.matchRating})
        tableView.reloadData()
    }
    
    func tapActionRose() {
        wines = roseWines
        wines.sortInPlace({$0.matchRating > $1.matchRating})
        tableView.reloadData()
    }
    
    func tapActionRed() {
        wines = redWines
        wines.sortInPlace({$0.matchRating > $1.matchRating})
        tableView.reloadData()
    }
    
    func tapActionDessert() {
        wines = dessertWines
        wines.sortInPlace({$0.matchRating > $1.matchRating})
        tableView.reloadData()
    }
}