//
//  TimeTableViewCell.swift
//  SchoolToday
//
//  Created by Podvorniy Egor on 15/11/2018.
//  Copyright © 2018 Podvorniy Ivan. All rights reserved.
//

import UIKit

class TimeTableViewCell: UITableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var Times: UILabel!
    
    @IBOutlet weak var Avatar: UIImageView!
    @IBOutlet weak var Subject: UILabel!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
