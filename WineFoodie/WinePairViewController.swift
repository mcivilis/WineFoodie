//
//  WinePairViewController.swift
//  WineFoodie
//
//  Created by Maria Civilis on 2016-02-25.
//  Copyright © 2016 mcivilis. All rights reserved.
//

import UIKit

enum wineGroup : String {
    case Red
    case White
    case Rose
    case Sparkling
    case Dessert
}

protocol WinePairViewControllerDelegate {
    func didFinishLoading(status: Bool)
}

class WinePairViewController: UIViewController, DataManagerDelegate, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet var dessertImage: UIImageView!
    @IBOutlet var redImage: UIImageView!
    @IBOutlet var roseImage: UIImageView!
    @IBOutlet var whiteImage: UIImageView!
    @IBOutlet var sparklingImage: UIImageView!
    
    var delegate : WinePairViewControllerDelegate?
    var foodType : Foods?
    var dataManager : DataManager!
    var winePairModel = WinePairModel()
    var wines = [LCBOWine]()
    var sparklingWines = [LCBOWine]()
    var whiteWines = [LCBOWine]()
    var roseWines = [LCBOWine]()
    var redWines = [LCBOWine]()
    var dessertWines = [LCBOWine]()
    var finishedLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareProperties()
        configureGestures()
                
        if finishedLoading {
            activityIndicatorView.stopAnimating()
            winePairModel.prepare(dataManager.wineList, foodType: foodType!)
            loadLCBOData()
        }
    }
    
    func didUpdateWineListWithOptions(optionsUpdated: Int) {
       //make optional
    }
    
    func didUpdateRecepes(recipesUpdated: Int) {
        
        if (recipesUpdated == dataManager.wineList.count) {
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.activityIndicatorView.stopAnimating()
            })
            winePairModel.prepare(dataManager.wineList, foodType: foodType!)
            finishedLoading = true
            delegate?.didFinishLoading(finishedLoading)
            loadLCBOData()
        }
    }
    
//MARK: Table View Data Source
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wines.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.textLabel!.text = wines[indexPath.row].name
        return cell
    }
    

        

//MARK: Table View Delegate

    
    
}
