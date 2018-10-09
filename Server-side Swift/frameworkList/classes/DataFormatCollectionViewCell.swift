//
//  DataFormatCollectionViewCell.swift
//  Server-side Swift
//
//  Created by Jens Van Steen on 07/05/2018.
//  Copyright © 2018 Jens Van Steen. All rights reserved.
//

import UIKit

class DataFormatCollectionViewCell: UICollectionViewCell {
    
    var url: String?
    
   
    @IBOutlet weak var backgroundcolor: UIView!
    @IBOutlet weak var formatLabel: UILabel!
    @IBOutlet weak var formatImage: UIImageView!
    
    
}
