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

    @IBAction func tapActionZoomImage(sender: UITapGestureRecognizer) {
        
        img = UIImageView(image: imageView.image)
        img.frame = self.imageView.bounds
        scrollView.addSubview(img)
        img.contentMode = .ScaleAspectFit
        img.clipsToBounds = true
        view.addSubview(scrollView)
        view.bringSubviewToFront(scrollView)
        scrollView.backgroundColor = .whiteColor()
        scrollView.userInteractionEnabled = true
        
        UIView.animateWithDuration(0.3) { () -> Void in
            self.scrollView.frame = self.view.frame
            self.img.frame = self.view.frame
        }
        
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:Selector("imageTapped"))
        img.userInteractionEnabled = true
        img.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func imageTapped() {
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.scrollView.frame = self.imageView.frame
            self.img.frame = self.imageView.bounds
            }) { (Bool) -> Void in
                self.imageView.image = self.img.image
                self.view.bringSubviewToFront(self.imageView)
        }
    }

}