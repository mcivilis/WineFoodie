//
//  ViewController.swift
//  WineFoodie
//
//  Created by Maria Civilis on 2016-02-22.
//  Copyright © 2016 mcivilis. All rights reserved.
//

import UIKit

class ViewController: UIViewController, DataManagerDelegate {
    
    var dataManager = DataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataManager.delegate = self
        dataManager.loadWines()
    }

//MARK: Data Manager Delegate

    func didUpdateWineListWithOptions(optionsUpdated: Int) {
        if optionsUpdated == dataManager.queryOptions().count {
            print("Wine list is update for every query option")
            print("There are", dataManager.wineList.count, "wines in the list")
            self.dataManager.loadRecipes()
        }
    }

    func didUpdateRecepes(recipesUpdated: Int) {
        if recipesUpdated == dataManager.wineList.count {
            print("Entire wine list is updated with recepes. Wine list count =", self.dataManager.wineList.count)
        }
    }
}