
//
//  ViewController.swift
//  CusomImagePicker
//
//  Created by Podvorniy Ivan on 25/08/2018.
//  Copyright © 2018 Podvorniy Ivan. All rights reserved.
//

import UIKit
import Photos
class PickerViewControlleViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    var helloWorldTimer: Timer!
    var load_index = [Int]()
    var ImageUrl = [URL]()
    @objc func sayHello()
    {
        if (edited)
        {
            self.updateAlbum()
            edited = false
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CameraCollectionViewCell
        if (indexPath.row < images.count)
        {
            cell.image.image = images[indexPath.row]
            cell.checkmarkView.checkMarkStyle = .GrayedOut
            cell.checkmarkView.tag = indexPath.row
            cell.checkmarkView.checked = false
            cell.checkmarkView.setNeedsDisplay()
        }
        return cell
    }
    // Called before the cell is displayed
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    // Called when the cell is displayed
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CameraCollectionViewCell
        if (cell.checkmarkView.checked == true)
        {
            self.load_index = self.load_index.filter {$0 != indexPath.row}
            cell.checkmarkView.checked = false
        }
        else
        {
            self.load_index.append(indexPath.row)
            cell.checkmarkView.checked = true
        }
        cell.setNeedsDisplay()
    }
    func listAlbums() {
        let options = PHFetchOptions()
        let userAlbums = PHAssetCollection.fetchAssetCollections(with: PHAssetCollectionType.album, subtype: PHAssetCollectionSubtype.any, options: options)
        userAlbums.enumerateObjects{ (object: AnyObject!, count: Int, stop: UnsafeMutablePointer) in
            if object is PHAssetCollection {
                let obj:PHAssetCollection = object as! PHAssetCollection
                
                let fetchOptions = PHFetchOptions()
                fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
                fetchOptions.predicate = NSPredicate(format: "mediaType = %d", PHAssetMediaType.image.rawValue)
                album.append(obj.localizedTitle!)
            }
        }
        
        for item in album {
            print(item)
        }
    }
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
    
    @IBAction func Donebtn(_ sender: Any) {
        for i in 0..<load_index.count
        {
            print(self.ImageUrl[i])
            var d = try! Data(contentsOf: self.ImageUrl[i])
            end.append(UIImage(data: d)!)
        }
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "PhotoVC") as! Photo_parent
        self.present(newViewController, animated: true, completion: nil)
    }
    func FetchCustomAlbumPhotos(albumName : String)
    {
        print(albumName)
        if (albumName != "Camera roll")
        {
            var assetCollection = PHAssetCollection()
            var albumFound = Bool()
            var photoAssets = PHFetchResult<AnyObject>()
            var fetchOptions = PHFetchOptions()
            fetchOptions.predicate = NSPredicate(format: "title = %@", albumName)
            let collection:PHFetchResult = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: fetchOptions)
            if let first_Obj:AnyObject = collection.firstObject{
                //found the album
                assetCollection = collection.firstObject as! PHAssetCollection
                albumFound = true
            }
            else { albumFound = false }
            var i = collection.count
            photoAssets = PHAsset.fetchAssets(in: assetCollection, options: nil) as! PHFetchResult<AnyObject>
            let imageManager = PHCachingImageManager()
            
            //        let imageManager = PHImageManager.defaultManager()
            photoAssets.enumerateObjects{(object: AnyObject!,
                count: Int,
                stop: UnsafeMutablePointer<ObjCBool>) in
                
                if object is PHAsset{
                    
                    let asset = object as! PHAsset
                    print("Inside  If object is PHAsset, This is number 1")
                    
                    let imageSize = CGSize(width: 100,
                                           height: 100)
                    
                    /* For faster performance, and maybe degraded image */
                    let options = PHImageRequestOptions()
                    options.deliveryMode = .fastFormat
                    options.isSynchronous = true
                    
                    imageManager.requestImage(for: asset,
                                              targetSize: imageSize,
                                              contentMode: .aspectFill,
                                              options: options,
                                              resultHandler: {
                                                (image, info) -> Void in
                                                if let photo = image
                                                {
                                                    self.images.append(image!)
                                                }
                                                
                    })
                    asset.requestContentEditingInput(with: PHContentEditingInputRequestOptions(), completionHandler: {(editingINpuy, info) in
                        if let input = editingINpuy, let imgUrl = input.fullSizeImageURL
                        {
                            self.ImageUrl.append(imgUrl)
                        }
                    })
                    
                }
            }
        }
        else
        {
            let fetchOptions = PHFetchOptions()
            fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate",ascending: false)]
            fetchOptions.predicate = NSPredicate(format: "mediaType = %d", PHAssetMediaType.image.rawValue)
            let collection = PHAsset.fetchAssets(with: fetchOptions)
            var i = collection.count
            let imageManager = PHCachingImageManager()
            
            //        let imageManager = PHImageManager.defaultManager()
            
            collection.enumerateObjects{(object: AnyObject!,
                count: Int,
                stop: UnsafeMutablePointer<ObjCBool>) in
                
                if object is PHAsset{
                    let asset = object as! PHAsset
                    print("Inside  If object is PHAsset, This is number 1")
                    
                    let imageSize = CGSize(width: 100,
                                           height: 100)
                    
                    /* For faster performance, and maybe degraded image */
                    let options = PHImageRequestOptions()
                    options.deliveryMode = .fastFormat
                    options.isSynchronous = true
                    
                    imageManager.requestImage(for: asset,
                                              targetSize: imageSize,
                                              contentMode: .aspectFill,
                                              options: options,
                                              resultHandler: {
                                                (image, info) -> Void in
                                                if let photo = image
                                                {
                                                    self.images.append(image!)
                                                }
                                                
                    })
                    asset.requestContentEditingInput(with: PHContentEditingInputRequestOptions(), completionHandler: {(editingINpuy, info) in
                        if let input = editingINpuy, let imgUrl = input.fullSizeImageURL
                        {
                            self.ImageUrl.append(imgUrl)
                        }
                    })
                    
                }
            }
        }
        self.CollectionView.reloadData()
    }
    
    @IBOutlet weak var CollectionView: UICollectionView!
    override func viewDidLoad() {
        end.removeAll()
        super.viewDidLoad()
        helloWorldTimer = Timer.scheduledTimer(timeInterval: 0.25, target: self, selector: #selector(PickerViewControlleViewController.sayHello), userInfo: nil, repeats: true)
        CollectionView.dataSource = self
        CollectionView.delegate = self
        album.append("Camera roll")
        listAlbums()
        Albumselect.setTitle(album[0], for: .normal)
        selected = album[0]
        print(album)
        FetchCustomAlbumPhotos(albumName: album[0])
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func SelectButton(_ sender: Any) {
        guard let popVC = storyboard?.instantiateViewController(withIdentifier: "VCPOP") else { return }
        popVC.modalPresentationStyle = .popover
        let popovervc =  popVC.popoverPresentationController
        popovervc?.delegate = self
        popovervc?.sourceView = self.Albumselect
        popovervc?.sourceRect = CGRect(x: self.Albumselect.bounds.midX, y: self.Albumselect.bounds.maxY, width: 0, height: 0)
        popVC.preferredContentSize = CGSize(width: 250, height: 250)
        self.present(popVC, animated: true)
    }
    @IBOutlet weak var Albumselect: UIButton!
    func updateAlbum()
    {
        print("fjnvkjf ")
        self.images.removeAll()
        self.ImageUrl.removeAll()
        self.FetchCustomAlbumPhotos(albumName: selected)
        self.Albumselect.setTitle(selected, for: .normal)
    }
}
extension PickerViewControlleViewController : UIPopoverPresentationControllerDelegate
{
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
        self.updateAlbum()
    }
}
