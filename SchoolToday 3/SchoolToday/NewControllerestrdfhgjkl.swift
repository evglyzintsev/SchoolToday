//
//  NewControllerestrdfhgjkl.swift
//  SchoolToday
//
//  Created by Podvorniy Ivan on 22/12/2018.
//  Copyright © 2018 Podvorniy Ivan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import AlamofireImage
class NewsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    var news_list = [String]()
    var images_names = [String]()
    var images = [UIImage]()
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "GalleryTableViewCell", for: indexPath) as! GalleryTableViewCell
        
        if (indexPath.row % 2 == 0)
        {
            
            cell.selectionStyle = UITableViewCellSelectionStyle.none;
            cell.AlbumName.frame = CGRect(x: cell.AlbumName.frame.origin.x - 67, y: cell.AlbumName.frame.origin.y, width: cell.AlbumName.frame.size.width, height: cell.AlbumName.frame.size.height)
            cell.Photo.frame = CGRect(x: cell.Photo.frame.origin.x - 67, y: cell.Photo.frame.origin.y, width: cell.Photo.frame.size.width, height: cell.Photo.frame.size.height)
            cell.Count.frame = CGRect(x: cell.Count.frame.origin.x - 67, y: cell.Count.frame.origin.y, width: cell.Count.frame.size.width, height: cell.Count.frame.size.height)
            cell.CountBg.frame = CGRect(x: cell.CountBg.frame.origin.x - 67, y: cell.CountBg.frame.origin.y, width: cell.CountBg.frame.size.width, height: cell.CountBg.frame.size.height)
            
        }
        if (self.images_names.count > 0)
        {
            cell.selectionStyle = UITableViewCellSelectionStyle.none;
            cell.AlbumName.text = self.news_list[indexPath.row]
            cell.Photo.image = images[indexPath.row]
            cell.Count.text = "21"
        }
        return cell
    }
}
