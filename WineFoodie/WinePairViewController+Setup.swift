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
        print("tap Sparkling")
        typeSelected = .Sparkling
        tableView.reloadData()
    }
    
    func tapActionWhite() {
        print("tap White")
        typeSelected = .White
        tableView.reloadData()
    }
    
    func tapActionRose() {
        print("tap Rose")
        typeSelected = .Rose
        tableView.reloadData()
    }
    
    func tapActionRed() {
        print("tap Red")
        typeSelected = .Red
        tableView.reloadData()
    }
    
    func tapActionDessert() {
        print("tap Dessert")
        typeSelected = .Dessert
        tableView.reloadData()
    }
}