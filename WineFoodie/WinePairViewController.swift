//
//  WinePairViewController.swift
//  WineFoodie
//
//  Created by Maria Civilis on 2016-02-25.
//  Copyright © 2016 mcivilis. All rights reserved.
//

import UIKit

class WinePairViewController: UIViewController, DataManagerDelegate {

    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet var sparklingTapGesture: UITapGestureRecognizer!
    @IBOutlet var whiteTapGesture: UITapGestureRecognizer!
    @IBOutlet var roseTapGesture: UITapGestureRecognizer!
    @IBOutlet var redTapGesture: UITapGestureRecognizer!
    @IBOutlet var dessertTapGesture: UITapGestureRecognizer!
    
    var foodType : Foods?
    var dataManager : DataManager!
    let winePairingModel = WinePairingModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataManager.delegate = self
        view.bringSubviewToFront(activityIndicatorView)
        activityIndicatorView.startAnimating()
    
    }
    
    func didUpdateWineListWithOptions(optionsUpdated: Int) {
       //optional
    }
    
    func didUpdateRecepes(recipesUpdated: Int) {
        if (recipesUpdated == dataManager.wineList.count) {
            activityIndicatorView.stopAnimating()
            print("Finished loading recipes")


        }
    }
}
