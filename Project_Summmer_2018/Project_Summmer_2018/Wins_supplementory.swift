//
//  ViewController.swift
//  Project_Summmer_2018
//
//  Created by Podvorniy Ivan on 16/07/2018.
//  Copyright © 2018 Podvorniy Ivan. All rights reserved.
//

import UIKit

class Wins_supplementory: UIViewController {
    override var prefersStatusBarHidden: Bool {
        return true
    }
    func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat {
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        
        label.sizeToFit()
        return label.frame.height
    }
    @IBOutlet weak var LongText: UITextView!
    override func viewDidLoad() {
        LongText.insertText(long_event!)
        var h = heightForView(text: long_event!, font: UIFont(name: "Helvetica Neue", size: 17)!, width: 396)
        LongText.frame =  CGRect(x: 0, y: 0, width: 394, height: min(716, h))
        self.view.sizeToFit()
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
