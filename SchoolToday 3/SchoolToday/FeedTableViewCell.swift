//
//  FeedTableViewCell.swift
//  SchoolToday
//
//  Created by Podvorniy Ivan on 16/11/2018.
//  Copyright © 2018 Podvorniy Ivan. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {
    @IBOutlet weak var Datas: UILabel!
    @IBOutlet weak var Avatar: UIImageView!
    @IBOutlet weak var EventText: UILabel!
    @IBOutlet weak var thierdImage: UIImageView!
    @IBOutlet weak var firstImage: UIImageView!
    @IBOutlet weak var secondImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
