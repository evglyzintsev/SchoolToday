//
//  addAchivmentViewController.swift
//  SchoolToday
//
//  Created by Podvorniy Ivan on 22/12/2018.
//  Copyright © 2018 Podvorniy Ivan. All rights reserved.
//

import UIKit
import BSImagePicker
import Photos
import Alamofire
class addAchivmentViewController: UIViewController {
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
    @IBAction func addAch(_ sender: Any) {
        var newImage = self.cropToBounds(image: self.im[0], width: 151, height : 219)
        var img_data = UIImagePNGRepresentation(newImage)
        var base64String = img_data?.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: Data.Base64DecodingOptions.RawValue(0)))
        
        let url = "http://5.63.159.177:5000/api/images/add"
        var parameters = [
            "image_base64" : base64String
        ]
        var images = ""
        Alamofire.request(url, method: .post, parameters: parameters).responseJSON { (responseData) -> Void in
            
            if var idd = responseData.result.value
            {
                print(idd)
                
                images += String(idd as! Int)
                let urll = "http://5.63.159.177:5000/api/achivments/add"
                let par = [
                    "text" : self.TextTitle.text as! String,
                    "date" : self.Time.text as! String,
                    "place" :  self.Place.text as! String ,
                    "imageurl" : images
                ]
                print(par)
                Alamofire.request(urll, method: .post, parameters: par).responseString { (responseData) -> Void in
                    
                    
                    
                }
                
            }
            
        }
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(
            withIdentifier: "WinsViewController") as! WinsViewController
        
        self.present(newViewController, animated: true, completion: nil)
    }
    @IBOutlet weak var TextTitle: UITextView!
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
    @IBOutlet weak var Time: UITextView!
    @IBOutlet weak var Place: UITextView!
    var im = [UIImage]()
    var SelectedAssets = [PHAsset]()
    @IBAction func addImage(_ sender: Any) {
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
                    self.im.append(thumbnail)
                }
            }
        }, completion: nil)

    }
    @IBOutlet weak var Image1: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

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
