//
//  SettingViewController.swift
//  SchoolToday
//
//  Created by Podvorniy Ivan on 22/12/2018.
//  Copyright © 2018 Podvorniy Ivan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class SettingViewController: UIViewController {
    @IBOutlet weak var LoginLabel: UITextView!
    
    @IBOutlet weak var passLabel: UITextView!
    @IBOutlet weak var emailLabel: UITextView!
    override func viewDidLoad() {
        let url = "http://5.63.159.177:5000/api/login/get_info"
        let parameters = [
            "login": login
        ]
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            
            switch response.result {
            case .success:
                var js = JSON(response.result.value)
                self.LoginLabel.text = login
                self.passLabel.text = ""
                self.emailLabel.text = js["email"].string!

                
            case .failure(let error):
                print(error)
            }
        }
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
