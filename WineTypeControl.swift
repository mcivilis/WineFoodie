//
//  WineTypeControl.swift
//  WineFoodie
//
//  Created by Maria Civilis on 2016-02-25.
//  Copyright © 2016 mcivilis. All rights reserved.
//

import UIKit

class WineTypeControl : UIView {
    
    let iconSize : Int = 40
    
    let whiteImage = UIImage(named: "white")
    let redImage = UIImage(named: "red")
    let roseImage = UIImage(named: "rose")
    let sparklingImage = UIImage(named: "sparkling")
    let dessertImage = UIImage(named: "dessert")
    
    
    // MARK: Initialization
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let images = [whiteImage, redImage, roseImage, sparklingImage, dessertImage]
        
        var frameOffset = 0
        for image in images {
            let wineView = UIView(frame: CGRect(x: 0, y: 0, width: iconSize * images.count, height: iconSize))
            let wineImageView = UIImageView(frame: CGRect(x: frameOffset, y: 0, width: iconSize, height: iconSize))
            wineImageView.image = image
            wineImageView.contentMode = UIViewContentMode.ScaleAspectFit
            wineView.addSubview(wineImageView)
            frameOffset = frameOffset + iconSize
        }
    }
}

