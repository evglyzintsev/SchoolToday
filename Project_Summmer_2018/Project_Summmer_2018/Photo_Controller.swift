import UIKit
import Alamofire
import SwiftyJSON
import Photos
import AlamofireImage
import BSImagePicker
class Photo_parent: UIViewController,UITableViewDataSource,UITableViewDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var tableView: UITableView!
    var height_of_cell = [CGFloat]()
    var  Photos_dev = [UIImage]()
    override var prefersStatusBarHidden: Bool {
        return true
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
    func convertBase64ToImage(imageString: String) -> UIImage {
        let imageData = Data(base64Encoded: imageString, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)!
        return UIImage(data: imageData)!
    }
    @IBOutlet weak var TEcach_but: UIButton!
    func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat {
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        
        label.sizeToFit()
        return label.frame.height
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
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    override func viewDidLoad() {
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.handleGesture))
        swipeLeft.direction = .right
        self.view.addGestureRecognizer(swipeLeft)
        self.widthOfScreen = UIScreen.main.bounds.width
        self.heightOfScreen = UIScreen.main.bounds.height
        if (status == "1")
        {
            self.TEcach_but.isHidden = false
        }
        else
        {
            self.TEcach_but.isHidden = true
        }
        for i in 0..<end.count
        {
            var newImage = resizeImage(image: end[i], newWidth: 375)
            let img_data = UIImagePNGRepresentation(newImage)
            var base64String = img_data?.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: Data.Base64DecodingOptions.RawValue(0)))
            
            let url = "http://127.0.0.1:5000/api/photos/add"
            
            
            let parameters = [
                "date": base64String
            ]
            print(parameters)
            Alamofire.request(url, method: .post, parameters: parameters).response { response in
                
                
            }
        }
        end.removeAll()
        Alamofire.request("http://127.0.0.1:5000/api/photos").responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                
                
                let event_out = JSON(responseData.value)
                
                for iii in 0..<event_out["data"].count
                {
                    if event_out["data"].count - iii < 20
                    {
    
                        self.Photos_dev.insert(self.resizeImage(image: self.convertBase64ToImage(imageString: event_out["data"][iii]["image"].string!), newWidth: self.widthOfScreen! - 39), at : 0)
                        
                        self.height_of_cell.insert(0, at: 0)
                    }
                }
                self.tableView.reloadData()
                
            }
        }

 
        super.viewDidLoad()
    }
    @objc func handleGesture()
    {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        transition.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "menuViewController") as! MenuViewController
        self.present(newViewController, animated: false, completion: nil)
    }
    var widthOfScreen: CGFloat?
    var heightOfScreen: CGFloat?
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row < Photos_dev.count
        {
            return Photos_dev[indexPath.row].size.height
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PhotoTableViewCell
        if indexPath.row < Photos_dev.count
        {
            cell.Photo.image = self.Photos_dev[indexPath .row]
            cell.Photo.frame = CGRect(x: 0, y: 0, width: Photos_dev[indexPath.row].size.width, height: Photos_dev[indexPath.row].size.height)
        }
        
        
        return cell
        
    }
    
    var SelectedAssets = [PHAsset]()
    var PhotoArray = [UIImage]()
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
                print(self.SelectedAssets)
            }
            print("get all images method called here")
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
                var newImage = self.resizeImage(image: self.PhotoArray[i], newWidth: 375)
                let img_data = UIImagePNGRepresentation(newImage)
                var base64String = img_data?.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: Data.Base64DecodingOptions.RawValue(0)))
                
                let url = "http://127.0.0.1:5000/api/photos/add"
                
                
                let parameters = [
                    "date" : base64String
                ]
                print(parameters)
                Alamofire.request(url, method: .post, parameters: parameters).response { response in
                    
                    
                }
            }
        }, completion: nil)
    }
    
    
}
