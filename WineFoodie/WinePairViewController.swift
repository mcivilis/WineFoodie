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

enum SortOptions : String {
    case Match
    case Price
    case Sugar
    case Inventory
}

protocol WinePairViewControllerDelegate {
    func didFinishLoading(status: Bool)
}

class WinePairViewController: UIViewController, DataManagerDelegate, UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate, UIActionSheetDelegate {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet var dessertImage: UIImageView!
    @IBOutlet var redImage: UIImageView!
    @IBOutlet var roseImage: UIImageView!
    @IBOutlet var whiteImage: UIImageView!
    @IBOutlet var sparklingImage: UIImageView!
    @IBOutlet var sparklingLabel: UILabel!
    @IBOutlet var whiteLabel: UILabel!
    @IBOutlet var roseLabel: UILabel!
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var dessertLabel: UILabel!
    @IBOutlet var sortOrder: UIBarButtonItem!
    
    var wineTypeLabels = [UILabel]!()
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
    var initialView : Bool!
    var sortAscending = false
    var sortOption = SortOptions.Match
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareProperties()
        //wineTypeLoadingActivity()
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
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! WineCell
        print("wines count", wines.count, "indexpath", indexPath.row)
        print("sparkling count", sparklingWines.count)
        print("white count", whiteWines.count)
        print("rose count", roseWines.count)
        print("red count", redWines.count)
        print("dessert count", dessertWines.count)
        
        let currentWine = wines[indexPath.row]
        
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
         
        return cell
    }

//MARK: Table View Delegate
    
//MARK: Segue
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showWineDetail" {
            
            let navController = segue.destinationViewController as! UINavigationController
            let wineDetailViewController = navController.topViewController as! WineDetailViewController

            if let indexPath = tableView.indexPathForSelectedRow {
                print("Seque. Selected wine = ",wines[indexPath.row].name)
                wineDetailViewController.currentWine = wines[indexPath.row]
            }
        }
    }


//MARK: Helpers
    
    func formatMatchRanking(matchRanking: Float) -> String {
        let percent = Float(roundf(matchRanking))
        let matchString = percent.description + "%"
        return matchString
    }
    
    func formatWinePrice(price: Int) -> String {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        formatter.locale = NSLocale(localeIdentifier: "en_CA")
        return formatter.stringFromNumber(price / 100)!
    }
    
    func downloadImageForCell(urlString: String, indexPath: NSIndexPath) {
        let url = NSURL(string: urlString)
        let urlRequest = NSURLRequest(URL: url!)
        let dataTask = NSURLSession.sharedSession().dataTaskWithRequest(urlRequest) { (data, response, error) -> Void in
            if error == nil {
                if let imageData = data {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        if let cell = self.tableView.cellForRowAtIndexPath(indexPath) as? WineCell {
                            if (self.tableView.visibleCells.contains(cell) == true) {
                                cell.wineImageView.image = UIImage(data: imageData)
                                cell.wineImageView.contentMode = .ScaleAspectFit
                            }
                        }
                    })
                }
            }
        }
        dataTask.resume()
    }
//MARK: IB Actions
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
        
        let matchRating = UIAlertAction(title: "Match Rating", style: .Default) { (UIAlertAction) -> Void in
            self.sortOption = .Match
            self.sort()
        }
        sortAlert.addAction(matchRating)
        
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
        
        self.presentViewController(sortAlert, animated: true, completion: nil)
    }

//MARK: Sort Actions
    
    func sort() {
        switch sortOption {
        case .Match     : sortByMatchRating()
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
            self.wines.sortInPlace({$0.currentPrice > $1.currentPrice})
        } else {
            self.wines.sortInPlace({$1.currentPrice > $0.currentPrice})
        }
    }
    
    func sortByMatchRating() {
        if (sortAscending == true) {
            self.wines.sortInPlace({$0.matchRating > $1.matchRating})
        } else {
            self.wines.sortInPlace({$1.matchRating > $0.matchRating})
        }
    }
    
    func sortBySugarContent() {
        if (sortAscending == true) {
            self.wines.sortInPlace({$0.sugarInGrams > $1.sugarInGrams})
        } else {
            self.wines.sortInPlace({$1.sugarInGrams > $0.sugarInGrams})
        }
    }
    
    func sortByInvenoryAvailable() {
        if (sortAscending == true) {
            self.wines.sortInPlace({$0.inventoryCount > $1.inventoryCount})
            
        } else {
            self.wines.sortInPlace({$1.inventoryCount > $0.inventoryCount})
        }
    }
}
