//
//  UIViewController+Alerts.swift
//  WineFoodie
//
//  Created by Masha on 2016-08-17.
//  Copyright © 2016 mcivilis. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func errorAlert(message:String) {
        
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .Alert)
        self.presentViewController(alert, animated: true, completion: nil)
    }
}