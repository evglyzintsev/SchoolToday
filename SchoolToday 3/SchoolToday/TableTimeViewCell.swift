//
//  TableTimeViewCell.swift
//  SchoolToday
//
//  Created by Podvorniy Ivan on 15/11/2018.
//  Copyright © 2018 Podvorniy Ivan. All rights reserved.
//

import UIKit

class TableTimeViewCell: UITableViewCell {
    @IBOutlet weak var Avatar: UIImageView!
    @IBOutlet weak var Subject: UILabel!
    @IBOutlet weak var Time: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
