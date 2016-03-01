//
//  WineDetailViewController+Actions.swift
//  WineFoodie
//
//  Created by Maria Civilis on 2016-03-01.
//  Copyright © 2016 mcivilis. All rights reserved.
//

import Foundation
import UIKit

extension WineDetailViewController {
    @IBAction func doneButton(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true) { () -> Void in
            self.initialLocationSet = false
        }
    }
}