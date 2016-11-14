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
 
    @IBAction func sortOrder(_ sender: UIBarButtonItem) {
        sortAscending = !sortAscending
        if (sortAscending == true) {
            sortOrder.title = "⇧"
        } else {
            sortOrder.title = "⇩"
        }
        sort()
    }
    
    @IBAction func sortAction(_ sender: UIBarButtonItem) {
        sortOptions()
    }
    
    func sortOptions() {
        let sortAlert = UIAlertController(title: "Sort by", message: nil, preferredStyle: .actionSheet)
        
        let price = UIAlertAction(title: "Price", style: .default) { (UIAlertAction) -> Void in
            self.sortOption = .Price
            self.sort()
        }
        sortAlert.addAction(price)
        
        let sugarContent = UIAlertAction(title: "Sugar Content", style: .default) { (UIAlertAction) -> Void in
            self.sortOption = .Sugar
            self.sort()
        }
        sortAlert.addAction(sugarContent)
        
        let inventory = UIAlertAction(title: "Number in Stock", style: .default) { (UIAlertAction) -> Void in
            self.sortOption = .Inventory
            self.sort()
        }
        sortAlert.addAction(inventory)
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        sortAlert.addAction(cancel)
        
        self.present(sortAlert, animated: true, completion: nil)
        sortAlert.view.tintColor = kWineFoodie.colors.burgundy
    }
    
    //MARK: Sort Actions
    
    func sort() {
        switch sortOption {
        case .Price     : sortByPrice()
        case .Sugar     : sortBySugarContent()
        case .Inventory : sortByInvenoryAvailable()
        }
        DispatchQueue.main.async { () -> Void in
            self.tableView.reloadData()
        }
    }

    func sortByPrice() {
        if (sortAscending == true) {
            wines.sort(by: {$0.currentPrice > $1.currentPrice})
        } else {
            wines.sort(by: {$1.currentPrice > $0.currentPrice})
        }
    }
    
    func sortBySugarContent() {
        if (sortAscending == true) {
            wines.sort(by: {$0.sugarInGrams > $1.sugarInGrams})
        } else {
            wines.sort(by: {$1.sugarInGrams > $0.sugarInGrams})
        }
    }
    
    func sortByInvenoryAvailable() {
        if (sortAscending == true) {
            wines.sort(by: {$0.inventoryCount > $1.inventoryCount})
        } else {
            wines.sort(by: {$1.inventoryCount > $0.inventoryCount})
        }
    }
}

