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
    
    @IBAction func doneButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true) { () -> Void in
            self.initialLocationSet = false
        }
    }

    @IBAction func tapActionZoomImage(_ sender: UITapGestureRecognizer) {
        
        img = UIImageView(image: imageView.image)
        img.frame = self.imageView.bounds
        scrollView.addSubview(img)
        img.contentMode = .scaleAspectFit
        img.clipsToBounds = true
        view.addSubview(scrollView)
        view.bringSubview(toFront: scrollView)
        scrollView.backgroundColor = .white()
        scrollView.isUserInteractionEnabled = true
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.scrollView.frame = self.view.frame
            self.img.frame = self.view.frame
        }) 
        
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(WineDetailViewController.imageTapped))
        img.isUserInteractionEnabled = true
        img.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func imageTapped() {
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.scrollView.frame = self.imageView.frame
            self.img.frame = self.imageView.bounds
            }, completion: { (Bool) -> Void in
                self.imageView.image = self.img.image
                self.view.bringSubview(toFront: self.imageView)
        }) 
    }

}
