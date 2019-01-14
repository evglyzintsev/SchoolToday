//
//  FeedViewController.swift
//  SchoolToday
//
//  Created by Podvorniy Ivan on 16/11/2018.
//  Copyright © 2018 Podvorniy Ivan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
struct ImagesListik{
    let ui_image1 : UIImage
    let ui_image2 : UIImage
    let ui_image3 : UIImage
    let textF : String
    let date : String
    
    
}
class FeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var feeds = [ImagesListik]()
    
    @IBOutlet weak var tableView: UITableView!
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedTableViewCell", for: indexPath) as! FeedTableViewCell
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none;
        
        cell.EventText.text = self.feeds[indexPath.row].textF
        cell.Datas.text = self.feeds[indexPath.row].date
        cell.secondImage.image = self.feeds[indexPath.row].ui_image2
        cell.firstImage.image = self.feeds[indexPath.row].ui_image1
        cell.thierdImage.image = self.feeds[indexPath.row].ui_image3
        cell.Avatar.image = UIImage(named: "Avatar.png")
        print(self.feeds)
        return cell
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.feeds.count;
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 378.0
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let url = "http://5.63.159.177:5000/api/feed/get_feed"
        Alamofire.request(url).responseJSON { (responseData) -> Void in
            if let j = responseData.result.value {
                let js = JSON(j)
                print(js)
                var val = js["values"] as JSON
                print(val)
                var arrrri = val["images"]
                var arrrrd = val["date"]
                var arrrrt = val["text"]
                for i in 0..<arrrrd.count
                {
                    var images = [UIImage]()
                    let urlforimagess = "http://5.63.159.177:5000/api/images/get_image"
                    
                    print(arrrri[i])
                    print(arrrrt[i])
                    print(arrrrd)
                    var arr = arrrri[i].string!.components(separatedBy: ",")
                    Alamofire.request(urlforimagess, method : .post, parameters : ["id" : "Optional(h" + arr[0] + "uy"]).responseData { response in
                        print(response.result.value)
                        if let image = response.result.value {
                            images.append(UIImage(data: image)!)
                            Alamofire.request(urlforimagess, method : .post, parameters : ["id" : "Optional(h" + arr[1] + "uy"]).responseData { response in
                                print(response.result.value)
                                if let image = response.result.value {
                                    images.append(UIImage(data: image)!)
                                    Alamofire.request(urlforimagess, method : .post, parameters : ["id" : "Optional(h" + arr[2] + "uy"]).responseData { response in
                                        print(response.result.value)
                                        if let image = response.result.value {
                                            images.append(UIImage(data: image)!)
                                            print(image)
                                            self.feeds.append(ImagesListik(ui_image1: images[0], ui_image2: images[1], ui_image3: images[2], textF: arrrrt[i].string!, date: arrrrd[i].string!))
                                            self.tableView.reloadData()
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.reloadData()
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
