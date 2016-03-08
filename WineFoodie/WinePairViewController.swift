//
//  WinePairViewController.swift
//  WineFoodie
//
//  Created by Maria Civilis on 2016-02-25.
//  Copyright © 2016 mcivilis. All rights reserved.
//

import UIKit


enum SortOptions : String {
    case Match
    case Price
    case Sugar
    case Inventory
}

class WinePairViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate, UIActionSheetDelegate {

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
    var wines : [LCBOWine]?
    var currentWineGroup = WineGroup.Red
    
    //refactor - > create a sort manager class
    var sortAscending = false
    var sortOption = SortOptions.Match
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        configureGestures()
        loadWines()
    }
    
//MARK: Table View Data Source
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rows = 0
        if let wineCount = wines?.count {
            rows = wineCount
        }
        return rows
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! WineCell
        
        if let currentWine = wines?[indexPath.row] {
            downloadImageForCell(currentWine.imageThumbURL, indexPath: indexPath)
            
            cell.name.text = currentWine.name
            cell.origin.text = currentWine.origin
            cell.varietal.text = currentWine.varietal
            cell.style.text = currentWine.style
            cell.sugarContent.text = currentWine.sugarContent
            cell.price.text = formatWinePrice(currentWine.currentPrice)
            let ranking = currentWine.matchRating
            cell.matchRanking.text = formatMatchRanking(ranking)
            cell.inventory.text = currentWine.inventoryCount.description
        }
        return cell
    }
    
//MARK: Segue
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showWineDetail" {
            
            let navController = segue.destinationViewController as! UINavigationController
            let wineDetailViewController = navController.topViewController as! WineDetailViewController

            if let indexPath = tableView.indexPathForSelectedRow,
                   wine = wines?[indexPath.row] {
                print("Seque. Selected wine = ",wine.name)
                wineDetailViewController.currentWine = wine
            }
        }
    }

    

}
