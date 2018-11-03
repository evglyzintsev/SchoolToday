//
//  ViewController.swift
//  Project_Summmer_2018
//
//  Created by Podvorniy Ivan on 16/07/2018.
//  Copyright © 2018 Podvorniy Ivan. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import WebKit
class TimeViewPArent: UIViewController, WKNavigationDelegate {
    override var prefersStatusBarHidden: Bool {
        return true
    }
    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.handleGesture))
        swipeLeft.direction = .right
        self.view.addGestureRecognizer(swipeLeft)
        super.viewDidLoad()
        let myURLString = "https://docs.google.com/spreadsheets/d/1yI8crMmfMbCFQMx5PdqBreCjTNK5r-aJeqgU9pWN85c/htmlview"
        let url = URL(string: myURLString)
        let request = URLRequest(url: url!)
        webView.navigationDelegate = self
        webView.frame = CGRect(x: 0, y: 44, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 44)
        webView.load(request)
        // Do any additional setup after loading the view, typically from a nib.
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
    
    
}
