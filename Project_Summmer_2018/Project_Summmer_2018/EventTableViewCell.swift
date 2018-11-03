//
//  WinsParentTableViewCell.swift
//  Project_Summmer_2018
//
//  Created by Podvorniy Ivan on 20/07/2018.
//  Copyright © 2018 Podvorniy Ivan. All rights reserved.
//

import UIKit

class EventParentTableViewCell: UITableViewCell {
    @IBOutlet weak var Photo: UIImageView!
    
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
