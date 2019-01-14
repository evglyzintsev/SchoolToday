//
//  TimeTableViewController.swift
//  SchoolToday
//
//  Created by Podvorniy Ivan on 15/11/2018.
//  Copyright © 2018 Podvorniy Ivan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class TimeTableViewController: UIViewController,  UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var TimeTableTableView: UITableView!
    var LessonList = [[String]]()
    var day = 0
    var LessonTimes = ["9:00-9:45", "9:55-10:40","10:50-11:35", "11:55-12:40", "12:50-13:35", "14:00-14:45", "14:55-15:40", "15:50-16:35", "16:45-17:30", "17:40-18:25", "18:35-19:20", "19:30-20:15", "20:25-21:10"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.TimeTableTableView.delegate = self
        self.TimeTableTableView.dataSource = self
        Alamofire.request("http://5.63.159.177:5000/api/schedule/get_schedule/7C").responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                
                
                let event_out = JSON(responseData.result.value)
                print(event_out)

                for j in 0..<7
                {
                    self.LessonList.append([])
                    for iii in 0..<event_out["ans"][j].count
                    {
                        self.LessonList[j].append(event_out["ans"][j][iii].string!)
                    }
                }
                self.TimeTableTableView.reloadData()
                print(self.LessonList)
            }
        }

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.LessonList.count > 0)
        {
            return self.LessonList[self.day].count
        }
        else
        {
            return 0;
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TimeTableTableView.dequeueReusableCell(withIdentifier: "TimeTableViewCell", for: indexPath) as! TimeTableViewCell
        cell.Subject.text = self.LessonList[self.day][indexPath.row]
        cell.Times.text = self.LessonTimes[indexPath.row]
        cell.Subject.isHidden = false
        cell.Times.isHidden = false
        cell.Avatar.image = #imageLiteral(resourceName: "Avatar.png")
        return cell
    }
    @IBAction func SAT(_ sender: Any) {
        day = 5
        self.TimeTableTableView.reloadData()
    }
    @IBAction func FRI(_ sender: Any) {
        day = 4
        self.TimeTableTableView.reloadData()
    }
    @IBAction func THU(_ sender: Any) {
        day = 3
        self.TimeTableTableView.reloadData()
    }
    
    @IBAction func WED(_ sender: Any) {
        day = 2
        self.TimeTableTableView.reloadData()
    }
    @IBAction func TUE(_ sender: Any) {
        day = 1
        self.TimeTableTableView.reloadData()
    }
    @IBAction func MON(_ sender: Any) {
        day = 0
        self.TimeTableTableView.reloadData()
    }
    @IBAction func Sun(_ sender: Any) {
        day = 6
        self.TimeTableTableView.reloadData()
    }
}
