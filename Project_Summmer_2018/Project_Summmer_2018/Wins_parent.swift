import UIKit
import AlamofireImage
import Alamofire
import SwiftyJSON
class WINSPARENTViewController: UIViewController,UITableViewDataSource,UITableViewDelegate, UIPopoverPresentationControllerDelegate {
    override var prefersStatusBarHidden: Bool {
        return true
    }
    @IBOutlet weak var Teachr_btn: UIButton!
    func convertBase64ToImage(imageString: String) -> UIImage {
        let imageData = Data(base64Encoded: imageString, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)!
        return UIImage(data: imageData)!
    }
    func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat {
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        
        label.sizeToFit()
        return label.frame.height
    }
    @IBOutlet weak var KOLHOS_LABel: UILabel!
    @IBOutlet weak var tableView: UITableView!
   
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage? {
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    var height_of_cell = [CGFloat]()
    var  Photos_dev = [UIImage]()
    var text_for_example = [String]()
    var des_roid = [String: String]()
    var des_rotime = [String: String]()
    var des_rodate = [String: String]()
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
            self.Teachr_btn.isHidden = false
        }
        else
        {
            self.Teachr_btn.isHidden = true
        }
        Alamofire.request("http://127.0.0.1:5000/api/achivments").responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                
                
                let event_out = JSON(responseData.value)
                
                for iii in 0...event_out["data"].count - 1
                {
                    if event_out["data"].count - iii < 20
                    {
                        self.text_for_example.insert(event_out["data"][iii]["des"].string!, at: 0)
                        self.Photos_dev.insert(self.resizeImage(image: self.convertBase64ToImage(imageString: event_out["data"][iii]["image"].string!), newWidth: self.widthOfScreen! - 39)!, at : 0)
                        self.des_roid[event_out["data"][iii]["des"].string!] = event_out["data"][iii]["long"].string!
                        self.des_rotime[event_out["data"][iii]["des"].string!] = event_out["data"][iii]["place"].string!
                        self.des_rodate[event_out["data"][iii]["des"].string!] = event_out["data"][iii]["date"].string!
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
        if (indexPath.row < self.Photos_dev.count)
        {
            self.height_of_cell[indexPath.row] = heightForView(text: self.text_for_example[indexPath.row], font: UIFont(name: "Helvetica Neue", size: 17)!, width: 375)
            return heightForView(text: self.text_for_example[indexPath.row], font: UIFont(name: "Helvetica Neue", size: 17)!, width: self.widthOfScreen! - 39) + self.Photos_dev[indexPath.row].size.height + 10
            
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WinsParentTableViewCell
        if (indexPath.row < self.Photos_dev.count)
        {
            cell.label.text = self.text_for_example[indexPath.row]
            cell.label.frame = CGRect(x: 0, y: 0, width: self.widthOfScreen! - 39, height: self.height_of_cell[indexPath.row])
            cell.photo.image = self.Photos_dev[indexPath.row]
            cell.photo.frame = CGRect(x: 0, y: cell.label.bounds.height + 10, width: self.widthOfScreen! - 39, height: self.Photos_dev[indexPath.row].size.height)
        }
        
        
        return cell
    }
    var widthOfScreen: CGFloat?
    var heightOfScreen: CGFloat?
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
    return .none
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let popVC = storyboard?.instantiateViewController(withIdentifier: "Wins_supp") else { return }
        popVC.modalPresentationStyle = .popover
        let popovervc =  popVC.popoverPresentationController
        popovervc?.delegate = self
        print(self.text_for_example[indexPath.row])
        long_event = des_roid[self.text_for_example[indexPath.row]]
        var h = heightForView(text: long_event!, font: UIFont(name: "Helvetica Neue", size: 17)!, width: self.widthOfScreen! - 20)
        popVC.preferredContentSize = CGSize(width:  self.widthOfScreen! - 2, height:  min(716, h))
        popovervc?.sourceRect = CGRect(x: 5, y: (self.heightOfScreen! - (min(self.heightOfScreen! - 20, h))) / 2, width: self.widthOfScreen! - 20, height: min(self.heightOfScreen! - 20, h))
        popovervc?.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
        popovervc?.sourceView = view
        self.present(popVC, animated: true)
        
    }
}
