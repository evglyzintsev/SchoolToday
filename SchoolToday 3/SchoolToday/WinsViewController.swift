//
//  WinsViewController.swift
//  SchoolToday
//
//  Created by Podvorniy Ivan on 07/12/2018.
//  Copyright © 2018 Podvorniy Ivan. All rights reserved.
//

import UIKit

import Alamofire
import SwiftyJSON
struct VanyaTheBest{
    let place : String
    let textF : String
    let date : String
}

class WinsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var ach = [VanyaTheBest]()
    @IBOutlet weak var tableView: UITableView!
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(self.ach)
        let cell = tableView.dequeueReusableCell(withIdentifier: "WinsTableViewCell", for: indexPath) as! WinsTableViewCell
        
        cell.Label.text = self.ach[indexPath.row].textF
        cell.Place.text = self.ach[indexPath.row].place
        cell.Time.text = self.ach[indexPath.row].date
        return cell;
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 129.0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ach.count
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    override func viewDidLoad() {
        
        let url = "http://5.63.159.177:5000/api/achivments/get_achivments"
        Alamofire.request(url).responseJSON { (responseData) -> Void in
            if let j = responseData.result.value {
                let js = JSON(j)
                var val = js["values"] as JSON
                var arrrrd = val["date"]
                var arrrrt = val["text"]
                var arrrrp = val["place"]
                
                print(val)
                if (arrrrd.count > 0)
                {
                    let urlforimagess = "http://5.63.159.177:5000/api/images/get_image"
                    Alamofire.request(urlforimagess, method : .post, parameters : ["id" : "Optional(h" +  val["images"][0].string! + "uy"]).responseData { response in
                        print(response.result.value)
                        if let image = response.result.value {
                            self.HeaderImage.image = UIImage(data : image)
                            self.HeaderTime.text = arrrrd[0].string!
                            self.HeaderLabel.text = arrrrt[0].string!
                            self.HeaderPlace.text = arrrrp[0].string!
                        }
                    }
                    for i in 1..<arrrrd.count
                    {
                        self.ach.append(VanyaTheBest(place: arrrrp[i].string!, textF: arrrrt[i].string!, date: arrrrd[i].string!))
                    }
                    self.tableView.reloadData()
                }
            }
        }
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.reloadData()
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet weak var HeaderTime: UILabel!
    @IBOutlet weak var HeaderPlace: UILabel!
    
    @IBOutlet weak var HeaderImage: UIImageView!
    
    @IBOutlet weak var HeaderLabel: UILabel!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
