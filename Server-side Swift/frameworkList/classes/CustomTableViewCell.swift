//
//  CustomTableViewCell.swift
//  Server-side Swift
//
//  Created by Jens Van Steen on 02/05/2018.
//  Copyright © 2018 Jens Van Steen. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var frameworkImage: UIImageView!
    @IBOutlet weak var frameworkLabel: UILabel!
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
