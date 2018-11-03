//
//  ViewController.swift
//  Project_Summmer_2018
//
//  Created by Podvorniy Ivan on 16/07/2018.
//  Copyright © 2018 Podvorniy Ivan. All rights reserved.
//

import UIKit

class Event_supplementory: UIViewController {
    override var prefersStatusBarHidden: Bool {
        return true
    }
    @IBOutlet weak var Image_supp: UIImageView!
    @IBOutlet weak var EVENT_SUP_INFO: UILabel!
    @IBOutlet weak var Event_supp: UILabel!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        EVENT_SUP_INFO.text = date_evnt! + ", " +  time_evnt!
        print(date_evnt!)
        print(time_evnt!)
        Event_supp.text = long_event
        Event_supp.sizeToFit()
        Image_supp.frame = CGRect(x: 20, y: Event_supp.frame.maxY + 20, width: (image_evnt?.size.width)!, height: (image_evnt?.size.height)!)
        Image_supp.image = image_evnt
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
