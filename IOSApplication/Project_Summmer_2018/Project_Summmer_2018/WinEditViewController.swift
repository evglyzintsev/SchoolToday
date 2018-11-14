//
//  WinEditViewController.swift
//  Project_Summmer_2018
//
//  Created by Podvorniy Ivan on 24/08/2018.
//  Copyright © 2018 Podvorniy Ivan. All rights reserved.
//

import UIKit
import Photos
import Alamofire
class WinEditViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var Info_text: UITextView!
    override var prefersStatusBarHidden: Bool {
        return true
    }
    @IBAction func Photo_add(_ sender: Any) {
        self.selectPicture()
    }
    @IBOutlet weak var Info_add_text: UITextView!
    var picker = UIImagePickerController()
    @IBOutlet weak var Time_text: UITextField!
    @IBOutlet weak var Date_text: UITextField!
    func convertBase64ToImage(imageString: String) -> UIImage {
        let imageData = Data(base64Encoded: imageString, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)!
        return UIImage(data: imageData)!
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
    func selectPicture() {
        
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    var endimage: UIImage?
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let possibleImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            endimage = possibleImage
        } else {
            return
        }
        var newImage = resizeImage(image: endimage!, newWidth: 375)
        let img_data = UIImagePNGRepresentation(newImage)
        var base64String = img_data?.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: Data.Base64DecodingOptions.RawValue(0)))
        
        let url = "http://127.0.0.1:5000/api/achivments/add"
        
        
        let parameters = [
            "date" : self.Date_text.text!,
            "place" : self.Time_text.text!,
            "class" : "NA",
            "short_description" : self.Info_text.text!,
            "description" : self.Info_text.text! + Info_add_text.text!,
            "image": base64String
        ]
        print(parameters)
        Alamofire.request(url, method: .post, parameters: parameters).response { response in
            
            
        }
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "WinVC") as! WINSPARENTViewController
        self.present(newViewController, animated: true, completion: nil)
        
        dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.handleGesture))
        swipeLeft.direction = .right
        self.view.addGestureRecognizer(swipeLeft)
        picker.delegate = self
        picker.sourceType = .photoLibrary
        super.viewDidLoad()
        print(end)

        // Do any additional setup after loading the view.
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
