//
//  CameraCollectionViewCell.swift
//  CusomImagePicker
//
//  Created by Podvorniy Ivan on 25/08/2018.
//  Copyright © 2018 Podvorniy Ivan. All rights reserved.
//

import UIKit

class CameraCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    var checkmarkView: SSCheckMark!
    
    @IBOutlet weak var myView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        checkmarkView = SSCheckMark(frame: CGRect(x: frame.width-40, y: 10, width: 35, height: 35))
        checkmarkView.backgroundColor = UIColor.clear
        myView.addSubview(checkmarkView)
    }
}
