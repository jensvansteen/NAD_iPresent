//
//  SectionCollectionViewCell.swift
//  Server-side Swift
//
//  Created by Jens Van Steen on 07/05/2018.
//  Copyright © 2018 Jens Van Steen. All rights reserved.
//

import UIKit

class SectionCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var cpu: UILabel!
    @IBOutlet weak var ram: UILabel!
    @IBOutlet weak var gpu: UILabel!
    @IBOutlet weak var image: UIImageView!
}
