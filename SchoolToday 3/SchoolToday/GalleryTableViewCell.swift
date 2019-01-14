//
//  GalleryTableViewCell.swift
//  SchoolToday
//
//  Created by Podvorniy Ivan on 07/12/2018.
//  Copyright © 2018 Podvorniy Ivan. All rights reserved.
//

import UIKit
import Alamofire
class GalleryTableViewCell: UITableViewCell {
    @IBOutlet weak var AlbumName: UILabel!
    
    @IBOutlet weak var CountBg: UIImageView!
    @IBOutlet weak var Photo: UIImageView!
    @IBOutlet weak var Count: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
