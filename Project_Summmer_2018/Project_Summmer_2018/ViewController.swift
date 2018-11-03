//
//  ViewController.swift
//  Project_Summmer_2018
//
//  Created by Podvorniy Ivan on 16/07/2018.
//  Copyright © 2018 Podvorniy Ivan. All rights reserved.
//

import UIKit
import EventKit
import Alamofire
import SwiftyJSON
import EventKitUI
final class FirstLaunch {
    
    let userDefaults: UserDefaults = .standard
    
    let wasLaunchedBefore: Bool
    var isFirstLaunch: Bool {
        return !wasLaunchedBefore
    }
    
    init() {
        let key = "com.any-suggestion.FirstLaunch.WasLaunchedBefore"
        let wasLaunchedBefore = userDefaults.bool(forKey: key)
        self.wasLaunchedBefore = wasLaunchedBefore
        if !wasLaunchedBefore {
            userDefaults.set(true, forKey: key)
        }
    }
    
}
class ViewController: UIViewController {
    override var prefersStatusBarHidden: Bool {
        return true
    }
    @IBOutlet weak var Error_label: UILabel!
    @IBOutlet weak var Password_fild: UITextField!
    @IBOutlet weak var Login_field: UITextField!
    @IBOutlet weak var RedWindow: UIImageView!
    @IBAction func LgiN_button(_ sender: Any) {
        let url = "http://127.0.0.1:5000/api/login"
        let login_enter:String = Login_field.text!
        let pass_enter:String = Password_fild.text!
    
        let parameters = [
            "login": login_enter,
            "password": pass_enter
        ]
        print(parameters)
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            
            switch response.result {
            case .success:
                if var value = response.result.value {
                    if JSON(value)["successfull"] == false
                    {
                        print(parameters)
                        self.Error_label.isHidden = false;
                        self.RedWindow.isHidden = false;
                    }
                    else
                    {
                        status = JSON(value)["status"].string!
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
    
    
    func addEventToCalendar(title: String, description: String?, startDate: Date, endDate: Date, completion: ((_ success: Bool, _ error: NSError?) -> Void)? = nil) {
        let eventStore = EKEventStore()
        
        eventStore.requestAccess(to: .event, completion: { (granted, error) in
            if (granted) && (error == nil) {
                let event = EKEvent(eventStore: eventStore)
                event.title = title
                event.startDate = startDate
                event.endDate = endDate
                event.notes = description
                event.calendar = eventStore.defaultCalendarForNewEvents
                do {
                    try eventStore.save(event, span: .thisEvent)
                } catch let e as NSError {
                    completion?(false, e)
                    return
                }
                completion?(true, nil)
            } else {
                completion?(false, error as NSError?)
            }
        })
    }
    
    
    
        // If no error occurs then turn the editing mode off, store the new calendar identifier and reload the calendars.
        
    

    override func viewDidLoad() {
        
        
            
        
        super.viewDidLoad()
        self.RedWindow.isHidden = true;
        self.Error_label.isHidden = true;
        Alamofire.request("http://127.0.0.1:5000/api/birthday").responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                var dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd.MM.yyyy"
                
                let birth = JSON(responseData.value)
                
                for iii in 0..<birth["data"].count
                {
                    print(birth["data"][iii]["name"].string!)
                    for ii in 2018...2020
                    {
                        var Birthday_date = dateFormatter.date(from: birth["data"][iii]["date"].string! + "." + String(ii))
                        self.addEventToCalendar(title: birth["data"][iii]["name"].string!, description: "BithDay of Pupil", startDate: Birthday_date!, endDate: Birthday_date!)
                    }
                    
                    
                }
                
            }
        }
        Alamofire.request("http://127.0.0.1:5000/api/olymps").responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                var dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
                
                let birth = JSON(responseData.value)
                
                for iii in 0..<birth["data"].count
                {
                    var timeStart = birth["data"][iii]["Date"].string! + " " + birth["data"][iii]["Start"].string!
                    var timeEnd = birth["data"][iii]["Date"].string! + " " + birth["data"][iii]["end"].string!
                    
                    self.addEventToCalendar(title: "Олимпиада",description: "Место:" + birth["data"][iii]["place"].string! + "\n" + birth["data"][iii]["des"].string!, startDate: dateFormatter.date(from: timeStart)!, endDate: dateFormatter.date(from: timeEnd)!)
                    
                    
                }
                
            }
        }
        // Specify date components
        /*
        var dateComponentss = DateComponents()
        dateComponentss.year = 2018
        dateComponentss.month = 7
        dateComponentss.day = 24
        var dateComponentsss = DateComponents()
        dateComponentsss.year = 2018
        dateComponentsss.month = 7
        dateComponentsss.day = 25
        addEventToCalendar(title: "Girlfriend birthday", description: "Remember or die!", startDate: dateComponentss, endDate: dateComponentsss)
        var eventstore = EKEventStore()
        var olymp = EKCalendar(for: EKEntityType, eventStore: eventstore)
 */
        

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}

