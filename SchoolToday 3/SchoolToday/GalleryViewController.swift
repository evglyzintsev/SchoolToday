//
//  GalleryViewController.swift
//  SchoolToday
//
//  Created by Podvorniy Ivan on 07/12/2018.
//  Copyright © 2018 Podvorniy Ivan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import AlamofireImage
class GalleryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    var galleryList = [String]()
    var firstImages = [String]()
    var images = [UIImage]()
    func cropToBounds(image: UIImage, width: Double, height: Double) -> UIImage {
        
        let cgimage = image.cgImage!
        let contextImage: UIImage = UIImage(cgImage: cgimage)
        let contextSize: CGSize = contextImage.size
        var posX: CGFloat = 0.0
        var posY: CGFloat = 0.0
        var cgwidth: CGFloat = CGFloat(width)
        var cgheight: CGFloat = CGFloat(height)
        
        // See what size is longer and create the center off of that
        if contextSize.width > contextSize.height {
            posX = ((contextSize.width - contextSize.height) / 2)
            posY = 0
            cgwidth = contextSize.height
            cgheight = contextSize.height
        } else {
            posX = 0
            posY = ((contextSize.height - contextSize.width) / 2)
            cgwidth = contextSize.width
            cgheight = contextSize.width
        }
        
        let rect: CGRect = CGRect(x: posX, y: posY, width: cgwidth, height: cgheight)
        
        // Create bitmap image from context using the rect
        let imageRef: CGImage = cgimage.cropping(to: rect)!
        
        // Create a new image based on the imageRef and rotate back to the original orientation
        let image: UIImage = UIImage(cgImage: imageRef, scale: image.scale, orientation: image.imageOrientation)
        
        return image
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "GalleryTableViewCell", for: indexPath) as! GalleryTableViewCell
        if (self.firstImages.count > 0)
        {
            if (indexPath.row % 2 == 1)
            {
                
                cell.selectionStyle = UITableViewCellSelectionStyle.none;
                cell.AlbumName.frame = CGRect(x: cell.AlbumName.frame.origin.x - 67, y: cell.AlbumName.frame.origin.y, width: cell.AlbumName.frame.size.width, height: cell.AlbumName.frame.size.height)
                cell.Photo.frame = CGRect(x: cell.Photo.frame.origin.x - 67, y: cell.Photo.frame.origin.y, width: cell.Photo.frame.size.width, height: cell.Photo.frame.size.height)
                cell.Count.frame = CGRect(x: cell.Count.frame.origin.x - 67, y: cell.Count.frame.origin.y, width: cell.Count.frame.size.width, height: cell.Count.frame.size.height)
                cell.CountBg.frame = CGRect(x: cell.CountBg.frame.origin.x - 67, y: cell.CountBg.frame.origin.y, width: cell.CountBg.frame.size.width, height: cell.CountBg.frame.size.height)
                
            }
            if (self.firstImages.count > 0)
            {
                cell.selectionStyle = UITableViewCellSelectionStyle.none;
                cell.AlbumName.text = self.galleryList[indexPath.row]
                cell.Photo.image = images[indexPath.row]
                
            }
        }
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let array = [String]()
        gall = ""
        if (self.firstImages.count > 0)
        {
            let array = self.firstImages[indexPath.row].components(separatedBy: ",")
            imageslist = array
        }
        gall = self.galleryList[indexPath.row]

        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "GallerySupViewController") as! GalletySupViewController
        
        self.present(newViewController, animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 215.0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return max(self.firstImages.count, 1)
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    override func viewDidLoad() {
        let url = "http://5.63.159.177:5000/api/gallery/list"
        Alamofire.request(url).responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                
                
                let event_out = JSON(responseData.value)
                if var mas = event_out["data"].array {
                    for i in mas
                    {
                        let urlforimages = "http://5.63.159.177:5000/api/gallery/get_images"
                        let parameters = [
                            "label": i.string!,
                            ]
                        self.galleryList.append(i.string!)

                        Alamofire.request(urlforimages, method : .post, parameters: parameters).responseString { (responseData) -> Void in
                            if (responseData.result.value != nil)
                            {
                                var s = responseData.result.value as! String
                                if (s.count > 0)
                                {
                                    s.remove(at: s.startIndex)
                                    self.firstImages.append(s);
                                    let urlforimagess = "http://5.63.159.177:5000/api/images/get_image"
                                    let array = s.components(separatedBy: ",")
                                    
                                    let parameters = [
                                        "id": array.first
                                    ]
                                    print(array.first)
                                    Alamofire.request(urlforimagess, method : .post ,parameters : parameters).responseData { response in
                                        print(response.result.value)
                                        if let image = response.result.value {
                                            self.images.append(UIImage(data: image)!)
                                            print(image)
                                            self.tableView.reloadData()
                                        }
                                    }
                                }
                                
                            }
                        }
                    }
                }
            }
        }
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func add()
    {
        //1. Create the alert controller.
        let alert = UIAlertController(title: "Добавить галлерею", message: "Введите название", preferredStyle: .alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.text = "Название"
        }
        
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            var par =
            [
                "label" : textField?.text
            ]
            Alamofire.request("http://5.63.159.177:5000/api/gallery/add/label", method : .post, parameters : par).responseString { response in
            }
        }))
        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func addGal(_ sender: Any) {
        add()
    }
}





















/*
 let url = "http://5.63.159.177:5000/api/gallery/list"
 Alamofire.request(url).responseJSON { (responseData) -> Void in
 if((responseData.result.value) != nil) {
 
 
 let event_out = JSON(responseData.value)
 if var mas = event_out["data"].array {
 for i in mas
 {
 print(i)
 self.galleryList.append(i.string!)
 }
 }
 }
 }
 
 */
/*
 var newImage = #imageLiteral(resourceName: "AvatarIA.png")
 let img_data = UIImagePNGRepresentation(newImage)
 var base64String = img_data?.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: Data.Base64DecodingOptions.RawValue(0)))
 
 let url = "http://5.63.159.177:5000/api/images/add"
 let parameters = [
 "image_base64" : base64String
 ]
 Alamofire.request(url, method: .post, parameters: parameters).responseString { (responseData) -> Void in
 if var idd = responseData.result.value {
 print(idd)
 }
 print(responseData.result.value)
 }
 */
/*
 let url = "http://5.63.159.177:5000/api/gallery/add/label"
 let parameters = [
 "label" : "TESTTESTTEST"
 ]
 
 Alamofire.request(url, method: .post, parameters: parameters).responseString { (responseData) -> Void in
 if((responseData.result.value) != nil) {
 
 
 let event_out = (responseData.value)
 print(event_out)
 }
 }
 */

// Do any additional setup after loading the view.
