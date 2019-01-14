//
//  GalletySupViewController.swift
//  SchoolToday
//
//  Created by Podvorniy Ivan on 19/12/2018.
//  Copyright © 2018 Podvorniy Ivan. All rights reserved.
//

import UIKit
import Alamofire
import BSImagePicker
import Photos
import SwiftyJSON
class GalletySupViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    var images = [UIImage]()
    var SelectedAssets = [PHAsset]()
    var PhotoArray = [UIImage]()
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
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        
        if let newImage = UIGraphicsGetImageFromCurrentImageContext()
        {
            UIGraphicsEndImageContext()
            return newImage
        }
        return image
    }
    func checkPermission() {
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch photoAuthorizationStatus {
        case .authorized:
            print("Access is granted by user")
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({
                (newStatus) in
                print("status is \(newStatus)")
                if newStatus ==  PHAuthorizationStatus.authorized {
                    /* do stuff here */
                    print("success")
                }
            })
            print("It is not determined until now")
        case .restricted:
            // same same
            print("User do not have access to photo album.")
        case .denied:
            // same same
            print("User has denied the permission.")
        }
    }
    @IBAction func addPhoto(_ sender: Any) {
        let vc = BSImagePickerViewController()
        vc.maxNumberOfSelections = 10
        
        bs_presentImagePickerController(vc, animated: true,
                                        select: { (asset: PHAsset) -> Void in
                                            print("Selected: \(asset)")
        }, deselect: { (asset: PHAsset) -> Void in
            print("Deselected: \(asset)")
        }, cancel: { (assets: [PHAsset]) -> Void in
            print("Cancel: \(assets)")
        }, finish: { (assets: [PHAsset]) -> Void in
            print("Finish: \(assets)")
            print(assets.count)
            for i in 0..<assets.count
            {
                self.SelectedAssets.append(assets[i])
            }
            if self.SelectedAssets.count != 0{
                for i in 0..<self.SelectedAssets.count{
                    let manager = PHImageManager.default()
                    let option = PHImageRequestOptions()
                    var thumbnail = UIImage()
                    option.isSynchronous = true
                    manager.requestImage(for: self.SelectedAssets[i], targetSize: CGSize(width: 200, height: 200), contentMode: .aspectFill, options: option, resultHandler: {(result, info)->Void in
                        thumbnail = result!
                    })
                    self.PhotoArray.append(thumbnail)
                }
            }
            for i in 0..<self.PhotoArray.count
            {
                var newImage = self.cropToBounds(image: self.PhotoArray[i], width: 375, height: 216)
                let img_data = UIImagePNGRepresentation(newImage)
                var base64String = img_data?.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: Data.Base64DecodingOptions.RawValue(0)))
                
                let url = "http://5.63.159.177:5000/api/images/add"
                let parameters = [
                    "image_base64" : base64String
                ]
                
                Alamofire.request(url, method: .post, parameters: parameters).responseJSON { (responseData) -> Void in
                    if var idd = responseData.result.value {
                        var iddd = JSON(idd)
                        
                        let url = "http://5.63.159.177:5000/api/gallery/add/image"
                        let parameters = [
                            "label" : gall,
                            "image_id" : (idd as! Int)
                            ] as [String : Any]
                        Alamofire.request(url, method: .post, parameters: parameters).responseString { (responseData) -> Void in
                        }
                    }
                }
            }
        }, completion: nil)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 216.0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.images.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GalleryFullTableViewCell", for: indexPath) as! GalleryFullTableViewCell
        cell.Photo.image = images[indexPath.row]
        return cell
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    override func viewDidLoad() {
        let urlforimagess = "http://5.63.159.177:5000/api/images/get_image"
        print(imageslist)
        for i in 0..<imageslist.count
        {
            if (imageslist[i] == "")
            {
                continue
            }
            Alamofire.request(urlforimagess, method : .post, parameters : ["id" : "Optional(h" + imageslist[i] + "uy"]).responseData { response in
                print(response.result.value)
                if let image = response.result.value {
                    self.images.append(UIImage(data: image)!)
                    print(image)
                    self.tableView.reloadData()
                }
            }
        }
        self.tableView.delegate = self
        self.tableView.dataSource = self
        checkPermission()
        // Do any additional setup after loading the view.
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

}
