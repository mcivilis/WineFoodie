//
//  WinePairViewController.swift
//  WineFoodie
//
//  Created by Maria Civilis on 2016-02-25.
//  Copyright © 2016 mcivilis. All rights reserved.
//

import UIKit

class WinePairViewController: UIViewController, DataManagerDelegate {

    @IBOutlet var sparklingTapGesture: UITapGestureRecognizer!
    @IBOutlet var whiteTapGesture: UITapGestureRecognizer!
    @IBOutlet var roseTapGesture: UITapGestureRecognizer!
    @IBOutlet var redTapGesture: UITapGestureRecognizer!
    @IBOutlet var dessertTapGesture: UITapGestureRecognizer!
    
    var foodType : Foods?
    var dataManager : DataManager!
    var winePairingModel = WinePairingModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataManager.delegate = self
    
    }
    
    func didUpdateWineListWithOptions(optionsUpdated: Int) {
       //optional
    }
    
    func didUpdateRecepes(recipesUpdated: Int) {
        if (recipesUpdated == dataManager.wineList.count) {
            print("Finished loading wine list")
        }
    }
}
