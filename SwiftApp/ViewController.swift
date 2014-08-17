//
//  ViewController.swift
//  SwiftApp
//
//  Created by Leon on 2014/8/16.
//  Copyright (c) 2014年 Leon. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,NSURLConnectionDataDelegate{
    
    var data:NSMutableData = NSMutableData()
    
    var name:String="Hello World"
    
    @IBOutlet var label:UILabel!
    @IBOutlet var xxx:UILabel!
    @IBOutlet var image:UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.label.text=name;
//        self.image.image=UIImage(named: "rain.png")
        //png 可以忽略 官方建議png
        let background = UIImage(named: "rainbackground.jpg")
        self.view.backgroundColor = UIColor(patternImage: background)
        
        var restAPI:String = "http://api.openweathermap.org/data/2.5/weather?q=Taipei"
        var url :NSURL = NSURL(string:restAPI)
        var request:NSURLRequest = NSURLRequest(URL:url)
        var connection: NSURLConnection = NSURLConnection(request: request, delegate: self,startImmediately:true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func connection(connection: NSURLConnection!, didReceiveData dataReceived: NSData!) {
        println("connection");
        self.data.appendData(dataReceived)
        
        var json = NSString(data: self.data, encoding : NSUTF8StringEncoding )
        println(json)
        
        var error:NSError?
        let jsonDictionary =  NSJSONSerialization.JSONObjectWithData(self.data, options: NSJSONReadingOptions.MutableContainers, error: &error) as NSDictionary
        
        let temp:AnyObject?=jsonDictionary["main"]?["temp"]
        
        let weaterTempCelsius=Int(round((temp!.floatValue-273.15)))
        
        let weaterTempFahrenheit = Int(round(((temp!.floatValue-273.15)*1.8)+32))
        
        self.xxx.text = "\(weaterTempCelsius)"
        
        let singleFingerTap = UITapGestureRecognizer(target: self, action: "handleSingleTab:")
        self.view.addGestureRecognizer(singleFingerTap)
        
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection!) {
        println("did");
    }

}

