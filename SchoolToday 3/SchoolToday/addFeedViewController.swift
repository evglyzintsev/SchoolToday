//
//  addFeedViewController.swift
//  SchoolToday
//
//  Created by Podvorniy Ivan on 22/12/2018.
//  Copyright © 2018 Podvorniy Ivan. All rights reserved.
//

import UIKit
import BSImagePicker
import SwiftyJSON
import Alamofire
import AlamofireImage
import Photos
class addFeedViewController: UIViewController {
    var FirstI = [UIImage]()
    var SecondI = [UIImage]()
    var ThirdI = [UIImage]()
    var SelectedAssets = [PHAsset]()
    func compThird()
    {
        if (ThirdI.count > 0)
        {
            self.ThirdImage.setImage(self.ThirdI[0], for: .normal)

        }
    }
    func compSecond()
    {
        if (SecondI.count > 0)
        {
            self.SecondImage.setImage(self.SecondI[0], for: .normal)
            
        }
    }
    func compFirst()
    {
        if (FirstI.count > 0)
        {
            self.FirstImage.setImage(self.FirstI[0], for: .normal)
            
        }
        
    }
    @IBOutlet weak var TextField: UITextView!
    @IBAction func addThirdImage(_ sender: Any) {
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
            self.SelectedAssets = [PHAsset]()
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
                    self.ThirdI.append(thumbnail)

                }
            }
        }, completion: compThird)

    }
    @IBOutlet weak var FirstImage: UIButton!
    @IBOutlet weak var ThirdImage: UIButton!
    @IBAction func addSecondImage(_ sender: Any) {
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
            self.SelectedAssets = [PHAsset]()
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
                    self.SecondI.append(thumbnail)

                }
            }
        }, completion: compSecond)

    }
    @IBAction func addFirstImage(_ sender: Any) {
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
            self.SelectedAssets = [PHAsset]()
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
                    self.FirstI.append(thumbnail)
                }
            }
        }, completion: compFirst)

    }
    var timer = Timer()

    @IBOutlet weak var SecondImage: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        runTimer()
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
    func resizeImage(image: UIImage, newWidth: CGFloat, newHeight : CGFloat) -> UIImage {
        
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        
        if let newImage = UIGraphicsGetImageFromCurrentImageContext()
        {
            UIGraphicsEndImageContext()
            return newImage
        }
        return image
    }
    var f = 0
    var s = 0
    var th = 0
    @objc func updateTimer()
    {
        if (FirstI.count != f)
        {
            FirstImage.setImage(FirstI[0], for: .normal)
            f = FirstI.count
        }
        if (SecondI.count != s)
        {
            SecondImage.setImage(SecondI[0], for: .normal)
            s = SecondI.count
        }
        if (ThirdI.count != f)
        {
            ThirdImage.setImage(ThirdI[0], for: .normal)
            th = ThirdI.count
        }
    }
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
    
    func runTimer() {
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
    }
    @IBAction func addFeed(_ sender: Any) {
        var newImage = self.cropToBounds(image: self.FirstI[0], width: 151, height : 219)
        var img_data = UIImagePNGRepresentation(newImage)
        var base64String = img_data?.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: Data.Base64DecodingOptions.RawValue(0)))
        
        let url = "http://5.63.159.177:5000/api/images/add"
        var parameters = [
            "image_base64" : base64String
        ]
        var images = ""
        Alamofire.request(url, method: .post, parameters: parameters).responseJSON { (responseData) -> Void in

            if var idd = responseData.result.value {
                print(idd)
                
                images += String(idd as! Int)
                newImage = self.cropToBounds(image: self.SecondI[0], width: 153, height : 133)
                img_data = UIImagePNGRepresentation(newImage)
                base64String = img_data?.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: Data.Base64DecodingOptions.RawValue(0)))
                
                parameters = [
                    "image_base64" : base64String
                ]
                Alamofire.request(url, method: .post, parameters: parameters).responseJSON { (responseData) -> Void in
                    
                    if var idd = responseData.result.value {
                        print(idd)
                        images += ","
                        images += String(idd as! Int)

                        newImage = self.cropToBounds(image: self.ThirdI[0], width: 159, height : 136)
                        img_data = UIImagePNGRepresentation(newImage)
                        base64String = img_data?.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: Data.Base64DecodingOptions.RawValue(0)))
                        
                        parameters = [
                            "image_base64" : base64String
                        ]
                        Alamofire.request(url, method: .post, parameters: parameters).responseJSON { (responseData) -> Void in
                            if var idd = responseData.result.value {
                                print(idd)
                                images += ","
                                images += String(idd as! Int)
                                let par = [
                                    "author" : 1,
                                    "text" : self.TextField.text,
                                    "date" : "22.12.2018",
                                    "imageurl" : images,
                                    "post" : "{}"
                                    ] as [String : Any]
                                Alamofire.request("http://5.63.159.177:5000/api/feed/add", method: .post, parameters: par).responseJSON { (responseData) -> Void in
                                    if var idd = responseData.result.value {
                                        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                        let newViewController = storyBoard.instantiateViewController(withIdentifier: "FeedViewController") as! FeedViewController
                                        
                                        self.present(newViewController, animated: true, completion: nil)
                                    }
                                }
                            }
                        }
                        
                    }
                }
            }
        }
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(
            withIdentifier: "FeedViewController") as! FeedViewController
        
        self.present(newViewController, animated: true, completion: nil)
        
        
    }
    
}
