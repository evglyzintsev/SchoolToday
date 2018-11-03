//
//  ViewController.swift
//  Project_Summmer_2018
//
//  Created by Podvorniy Ivan on 16/07/2018.
//  Copyright © 2018 Podvorniy Ivan. All rights reserved.
//

import UIKit
import MessageUI
class MenuViewController: UIViewController, MFMailComposeViewControllerDelegate {
    override var prefersStatusBarHidden: Bool {
        return true
    }
    @IBAction func Calendar_buuton(_ sender: Any) {
        var calendarHook = "calshow://"
        var calendarURl = URL(string: calendarHook)
        if UIApplication.shared.canOpenURL(calendarURl!)
        {
            UIApplication.shared.openURL(calendarURl!)
        }
    }
    
    @IBAction func FeedBackBtn(_ sender: Any) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["ivan.podvorniy@yandex.ru"])
            mail.setMessageBody("<p></p>", isHTML: true)
            
            present(mail, animated: true)
        } else {
            // show failure alert
        }
    }
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
