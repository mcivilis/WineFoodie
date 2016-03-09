//
//  WinePairViewController.swift
//  WineFoodie
//
//  Created by Maria Civilis on 2016-02-25.
//  Copyright © 2016 mcivilis. All rights reserved.
//

import UIKit


enum SortOptions : String {
    case Price
    case Sugar
    case Inventory
}

class WinePairViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate, UIActionSheetDelegate, DataManagerProtocol {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet var dessertImage: UIImageView!
    @IBOutlet var redImage: UIImageView!
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var roseImage: UIImageView!
    @IBOutlet var roseLabel: UILabel!
    @IBOutlet var whiteImage: UIImageView!
    @IBOutlet var whiteLabel: UILabel!
    @IBOutlet var sparklingImage: UIImageView!
    @IBOutlet var sparklingLabel: UILabel!
    
    @IBOutlet var dessertLabel: UILabel!
    @IBOutlet var sortOrder: UIBarButtonItem!
    var wineGroupLabels = [UILabel]!()
    
    var dataManager = DataManager()
    var winePairs: [WinePair]!
    var wines = [LCBOWine]()
    var currentWineGroup = WineGroup.Red
    var sortAscending = false
    var sortOption = SortOptions.Inventory
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        configureGestures()
        loadWines()
    }
    
//MARK: Data Manager Delegate
    
    func didUpdateWineList() {
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            self.activityIndicatorView.stopAnimating()
            self.wines = self.dataManager.wineList
            self.tableView.reloadData()
        }
    }
    
//MARK: Table View Data Source
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wines.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! WineCell
        
        
        let currentWine = wines[indexPath.row]
        downloadImageForCell(currentWine.imageThumbURL, indexPath: indexPath)
        
        cell.name.text = currentWine.name
        cell.origin.text = currentWine.origin
        cell.varietal.text = currentWine.varietal
        cell.style.text = currentWine.style
        cell.sugarContent.text = currentWine.sugarContent
        cell.stock.text = currentWine.inventoryCount.description + " in stock"
        cell.price.text = formatWinePrice(currentWine.currentPrice)
        if (currentWine.stockType == "VINTAGES") {
            cell.vintage.text = "Vintage"
        } else {
            cell.vintage.text = ""
        }
        if (currentWine.isVQA == true) {
            cell.vqa.text = "VQA"
        } else {
            cell.vqa.text = ""
        }
        if (currentWine.isKosher == true) {
            cell.kosher.text = "Kosher"
        } else {
            cell.kosher.text = ""
        }
        if (currentWine.isSeasonal == true) {
            cell.seasonal.text = "Seasonal"
        } else {
            cell.seasonal.text = ""
        }
        
        return cell
    }
    
//MARK: Segue
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showWineDetail" {
            
            let navController = segue.destinationViewController as! UINavigationController
            let wineDetailViewController = navController.topViewController as! WineDetailViewController

            if let indexPath = tableView.indexPathForSelectedRow {
                let wine = wines[indexPath.row]
                wineDetailViewController.currentWine = wine
            }
        }
    }

    

}
