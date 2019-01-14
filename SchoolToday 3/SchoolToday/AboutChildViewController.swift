//
//  AboutChildViewController.swift
//  SchoolToday
//
//  Created by Podvorniy Ivan on 07/12/2018.
//  Copyright © 2018 Podvorniy Ivan. All rights reserved.
//

import UIKit

class AboutChildViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChildTableViewCell", for: indexPath) as! ChildTableViewCell
        
        cell.Avatar.image = #imageLiteral(resourceName: "AvatarIA.png");
        cell.Message.text = "Не делает Домашнее задание уже три года. Говорит, что собака съела. Беспокоюсь за вашу собаку."
        cell.Name.text = "Ivan Andreevich"
        cell.Time.text = "Apr 3, 1:22pm"
        return cell;
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135.0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
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
