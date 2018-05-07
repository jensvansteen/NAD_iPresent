//
//  ListItemTableViewCell.swift
//  Server-side Swift
//
//  Created by Jens Van Steen on 05/05/2018.
//  Copyright © 2018 Jens Van Steen. All rights reserved.
//

import UIKit

class ListItemTableViewCell: UITableViewCell {
  
    @IBOutlet weak var listItem: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
