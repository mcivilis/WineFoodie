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
    @IBOutlet var sparklingTapGesture: UITapGestureRecognizer!
    @IBOutlet var whiteTapGesture: UITapGestureRecognizer!
    @IBOutlet var roseTapGesture: UITapGestureRecognizer!
    @IBOutlet var redTapGesture: UITapGestureRecognizer!
    @IBOutlet var dessertTapGesture: UITapGestureRecognizer!
    
    var delegate : WinePairViewControllerDelegate?
    var foodType : Foods?
    var dataManager : DataManager!
    var finishedLoading = false
    var winePairModel = WinePairModel()
    
    var wines = [LCBOWine]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataManager.delegate = self
        
        view.bringSubviewToFront(activityIndicatorView)
        activityIndicatorView.startAnimating()
        
        if finishedLoading {
            activityIndicatorView.stopAnimating()
            winePairModel.prepare(dataManager.wineList, foodType: foodType!)
            print("finished loading RIGHT AFTER view did load")
            
            //Defauilt view is red wine
            displayWineList(.Red)
        }
        delegate?.didFinishLoading(finishedLoading)
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
            
            print("finished loading TRIGGERED BY PROTOCOL")
            
            //Defauilt view is red wine
            displayWineList(.Red)
        
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


//MARK: Helpers
    
    func displayWineList(type: wineGroup) {
        var test = 0
        var winePairList : [WinePair]!
        switch type {
        case .Red : winePairList = winePairModel.redWineList
        case.Rose : winePairList = winePairModel.roseWineList
        case.White : winePairList = winePairModel.whiteWineList
        case.Sparkling : winePairList = winePairModel.sparklingWineList
        case.Dessert : winePairList = winePairModel.dessertWineList
        }
        
        for winePair in winePairList {
            let plus = "+"
            let queryOptions = winePair.country.stringByReplacingOccurrencesOfString(" ", withString: plus) + plus
                + winePair.region.stringByReplacingOccurrencesOfString(" ", withString: plus) + plus
                + winePair.varietal.stringByReplacingOccurrencesOfString(" ", withString: plus)
            print(queryOptions, test)
            test++
            dataManager.lcboWineList(queryOptions, completion: { (lcboWineList) -> Void in
                self.wines = self.wines + lcboWineList
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.tableView.reloadData()
                })
            })
        }
    }

}
