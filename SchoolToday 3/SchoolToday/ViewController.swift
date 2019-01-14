//
//  ViewController.swift
//  SchoolToday
//
//  Created by Podvorniy Ivan on 14/11/2018.
//  Copyright © 2018 Podvorniy Ivan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class ViewController: UIViewController {
    @IBOutlet weak var PassShake: UIImageView!
    @IBOutlet weak var LoginShake: UIImageView!
    @IBAction func Login(_ sender: Any) {
        let url = "http://5.63.159.177:5000/api/login"
        let login_enter:String = LoginField.text!
        let pass_enter:String = PassField.text!
        
        let parameters = [
            "login": login_enter,
            "password": pass_enter
        ]
        
        print(parameters)
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default).responseString { response in
            
            switch response.result {
            case .success:
                if var value = response.result.value {
                    if value == "neOK"
                    {
                        let animationL = CABasicAnimation(keyPath: "positionL")
                        animationL.duration = 1.0
                        animationL.repeatCount = 4
                        animationL.autoreverses = true
                        animationL.fromValue = NSValue(cgPoint: CGPoint(x: self.LoginShake.center.x - 50, y: self.LoginShake.center.y))
                        animationL.toValue = NSValue(cgPoint: CGPoint(x: self.LoginShake.center.x + 50, y: self.LoginShake.center.y))
                        
                        self.LoginShake.layer.add(animationL, forKey: "positionL")
                        print(parameters)
                    }
                    else
                    {
                        login = login_enter
                        status = value
                        
                        print(value)
                        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let newViewController = storyBoard.instantiateViewController(withIdentifier: "menuViewController") as! MenuViewController
                        
                        self.present(newViewController, animated: true, completion: nil)
                        
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
        
    }
    @IBOutlet weak var LoginField: UITextView!
    
    @IBOutlet weak var PassField: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

