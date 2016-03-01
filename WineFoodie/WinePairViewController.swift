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
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! WineCell
        
        //downloadImageForCell(wines[indexPath.row].imageURL, indexPath: indexPath)
        if wines.count > 0 {
            cell.name.text = wines[indexPath.row].name
            cell.origin.text = wines[indexPath.row].origin
            cell.varietal.text = wines[indexPath.row].varietal
            cell.style.text = wines[indexPath.row].style
            cell.wineType.text = wines[indexPath.row].secondaryCategory
            cell.price.text = formatWinePrice(wines[indexPath.row].currentPrice)
            let ranking = wines[indexPath.row].matchRating
            cell.matchRanking.text = formatMatchRanking(ranking)
            
            if (ranking == 1) {
                cell.matchRanking.textColor = UIColor.greenColor()
            } else if (ranking > 0.33){
                cell.matchRanking.textColor = UIColor.darkGrayColor()
            } else {
                cell.matchRanking.textColor = UIColor.redColor()
            }
        }
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
                        let cell = self.tableView.cellForRowAtIndexPath(indexPath) as! WineCell
                        cell.wineImageView.image = UIImage(data: imageData)
                        cell.wineImageView.contentMode = .ScaleAspectFit
                        self.tableView.reloadData()
                    })
                }
            }
        }
        dataTask.resume()
    }
    
    
}
