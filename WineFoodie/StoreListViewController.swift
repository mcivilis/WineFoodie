//
//  StoreListViewController.swift
//  WineFoodie
//
//  Created by Maria Civilis on 2016-03-02.
//  Copyright © 2016 mcivilis. All rights reserved.
//

import Foundation
import UIKit


class StoreListViewController: UITableViewController {
    
    var storeLocations : [LCBOStore]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storeLocations.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! StoreCell
        cell.name.text = storeLocations[indexPath.row].name
        cell.address.text = storeLocations[indexPath.row].address
        cell.postalCode.text = storeLocations[indexPath.row].postalCode
        cell.city.text = storeLocations[indexPath.row].city
        cell.telephone.text = storeLocations[indexPath.row].telephone
        cell.distanceInMeters.text = storeLocations[indexPath.row].distanceInMeters.description + " meters"
        cell.quantity.text = storeLocations[indexPath.row].quantity.description
        return cell
    }

}
