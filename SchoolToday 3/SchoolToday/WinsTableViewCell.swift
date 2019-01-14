//
//  WinsTableViewCell.swift
//  SchoolToday
//
//  Created by Podvorniy Ivan on 07/12/2018.
//  Copyright © 2018 Podvorniy Ivan. All rights reserved.
//

import UIKit

class WinsTableViewCell: UITableViewCell {
    @IBOutlet weak var Place: UILabel!
    @IBOutlet weak var Time: UILabel!
    
    @IBOutlet weak var Label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
