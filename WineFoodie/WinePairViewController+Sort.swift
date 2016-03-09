//
//  WinePairViewController+Sort.swift
//  WineFoodie
//
//  Created by Maria Civilis on 2016-03-08.
//  Copyright © 2016 mcivilis. All rights reserved.
//



import Foundation
import UIKit

extension WinePairViewController {
 
    @IBAction func sortOrder(sender: UIBarButtonItem) {
        sortAscending = !sortAscending
        if (sortAscending == true) {
            sortOrder.title = "⇧"
        } else {
            sortOrder.title = "⇩"
        }
        sort()
    }
    
    @IBAction func sortAction(sender: UIBarButtonItem) {
        sortOptions()
    }
    
    func sortOptions() {
        let sortAlert = UIAlertController(title: "Sort by", message: nil, preferredStyle: .ActionSheet)
        
        let price = UIAlertAction(title: "Price", style: .Default) { (UIAlertAction) -> Void in
            self.sortOption = .Price
            self.sort()
        }
        sortAlert.addAction(price)
        
        let sugarContent = UIAlertAction(title: "Sugar Content", style: .Default) { (UIAlertAction) -> Void in
            self.sortOption = .Sugar
            self.sort()
        }
        sortAlert.addAction(sugarContent)
        
        let inventory = UIAlertAction(title: "Number in Stock", style: .Default) { (UIAlertAction) -> Void in
            self.sortOption = .Inventory
            self.sort()
        }
        sortAlert.addAction(inventory)
        
        let cancel = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        sortAlert.addAction(cancel)
        
        self.presentViewController(sortAlert, animated: true, completion: nil)
    }
    
    //MARK: Sort Actions
    
    func sort() {
        switch sortOption {
        case .Price     : sortByPrice()
        case .Sugar     : sortBySugarContent()
        case .Inventory : sortByInvenoryAvailable()
        }
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            self.tableView.reloadData()
        }
    }

    func sortByPrice() {
        if (sortAscending == true) {
            wines.sortInPlace({$0.currentPrice > $1.currentPrice})
        } else {
            wines.sortInPlace({$1.currentPrice > $0.currentPrice})
        }
    }
    
    func sortBySugarContent() {
        if (sortAscending == true) {
            wines.sortInPlace({$0.sugarInGrams > $1.sugarInGrams})
        } else {
            wines.sortInPlace({$1.sugarInGrams > $0.sugarInGrams})
        }
    }
    
    func sortByInvenoryAvailable() {
        if (sortAscending == true) {
            wines.sortInPlace({$0.inventoryCount > $1.inventoryCount})
        } else {
            wines.sortInPlace({$1.inventoryCount > $0.inventoryCount})
        }
    }
}

