//
//  PhotoTableViewCell.swift
//  Project_Summmer_2018
//
//  Created by Podvorniy Ivan on 22/07/2018.
//  Copyright © 2018 Podvorniy Ivan. All rights reserved.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {
    @IBOutlet weak var Photo: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
