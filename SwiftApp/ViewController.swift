//
//  ViewController.swift
//  SwiftApp
//
//  Created by Leon on 2014/8/16.
//  Copyright (c) 2014年 Leon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var name:String="Hello World"
    
    @IBOutlet var label:UILabel!
    @IBOutlet var image:UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.label.text=name;
        self.image.image=UIImage(named: "rain.png")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

