//
//  ViewController.swift
//  SwiftApp
//
//  Created by Leon on 2014/8/16.
//  Copyright (c) 2014年 Leon. All rights reserved.
//

import UIKit
import MediaPlayer;

class ViewController: UIViewController ,NSURLConnectionDataDelegate{
    
    var data:NSMutableData = NSMutableData()
    
    var name:String="Taipei"
    
    @IBOutlet var label:UILabel!
    @IBOutlet var xxx:UILabel!
    @IBOutlet var image:UIImageView!
    @IBOutlet var activity:UIActivityIndicatorView!
    
    var movie:MPMoviePlayerController!=MPMoviePlayerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        self.image.image=UIImage(named: "rain.png")
        //png 可以忽略 官方建議png
        let background = UIImage(named: "see.jpg")
        self.view.backgroundColor = UIColor(patternImage: background)
        
        let singleFingerTap = UITapGestureRecognizer(target: self, action: "handleSingleTab:")
        self.view.addGestureRecognizer(singleFingerTap)
         startConnection()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func connection(connection: NSURLConnection!, didReceiveData dataReceived: NSData!) {
        println("downloading")
        
        self.data.setData(dataReceived)
    }
    func connectionDidFinishLoading(connection: NSURLConnection!) {
        println("did");
        
        var json:NSString = NSString(data: self.data,encoding : NSUTF8StringEncoding)
        
        println(json)
        
        var error:NSError?
        let jsonDictionary = NSJSONSerialization.JSONObjectWithData(self.data, options: NSJSONReadingOptions.MutableContainers, error: &error) as NSDictionary
        
        let temp:AnyObject?=jsonDictionary["main"]?["temp"]
        
        let weaterTempCelsius=Int(round((temp!.floatValue-273.15)))
        
        let weaterTempFahrenheit = Int(round(((temp!.floatValue-273.15)*1.8)+32))
        
        let weather:NSArray = jsonDictionary["weather"] as NSArray
        
        let icon = weather[0]["icon"]
        
//        self.image.image = UIImage(named: "http://www.openweathermap.org/img/W/\(icon).png")
        
        self.xxx.text = "\(weaterTempCelsius)"
        
        self.data.setData(nil)
        self.image.image =  UIImage(data: NSData(contentsOfURL: NSURL(string:"http://www.openweathermap.org/img/w/\(icon).png")))
        
//        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
//            var test =  UIImage(data: NSData(contentsOfURL: NSURL(string:"http://www.openweathermap.org/img/w/\(icon).png")))
//            self.image.image = test
//        })
        activity.stopAnimating()
//        activity.hidesWhenStopped=true
        self.label.text=name
        
//        self.moviePlayerController.contentURL = NSURL.fileURLWithPath(filePath)
        
        
//        let viewRect = CGRect(x: 10, y: 100, width: 100, height: 100)
////        let myView:UIView = UIView(frame: viewRect)
//        var view: UIView! = UIView(frame: viewRect)
//
//        self.view.addSubview(self.movie.view)
//        
//        self.movie.contentURL = NSURL.fileURLWithPath("WeatherGirl.mp4")
//        self.movie.prepareToPlay()
//        self.movie.play()
    }
    
    override func viewDidAppear(animated: Bool)  {
        
        let viewRect = CGRect(x: -160, y: -400, width: 320, height: 180)
        self.movie.view.bounds = viewRect
        
        
//        let filePath = NSBundle.mainBundle().pathForResource("WeatherGirl", ofType: "mp4")
//        let filePath  = NSURL.fileURLWithPath("WeatherGirl.mp4")
        let filePath = NSURL(string: "http://r3---sn-u4o-u2xs.googlevideo.com/videoplayback?fexp=902408%2C908547%2C927622%2C931983%2C934024%2C934030%2C938008%2C940698%2C946013%2C951804&sparams=id%2Cinitcwndbps%2Cip%2Cipbits%2Citag%2Cratebypass%2Csource%2Cupn%2Cexpire&mv=m&upn=PapHXwXBA9o&itag=18&mt=1408257144&ip=49.218.123.2&mm=31&sver=3&expire=1408278789&source=youtube&ratebypass=yes&signature=D8BE1B986F3F06159977344711FD3AB91D727FBA.F3EF8F0D18C82A41125B84953FDC8DD8FA20267B&key=yt5&ms=au&mws=yes&ipbits=0&id=o-AOvKCS_8hl-sYlwsAhZj89RlyoilfLL7Yb8uTEq8SUDG&initcwndbps=1048000&signature=undefined&title=Weather+Girls%E5%A4%A9%E6%B0%A3%E5%A5%B3%E5%AD%A9%E3%80%90%E6%81%8B%E3%81%AE%E5%A4%A9%E6%B0%97%E4%BA%88%E5%A0%B1%E3%80%91+Music+Video")
        self.movie.contentURL =  filePath
        self.movie.prepareToPlay()
        self.movie.repeatMode = .One
        self.movie.controlStyle = .Embedded
        self.movie.scalingMode = .AspectFit
        self.view.addSubview(self.movie.view)
        
        
        
        self.movie.play()
        println("play movie")
    }
    
    
    func handleSingleTab(recognizer: UITapGestureRecognizer){
        startConnection()
    }
    func startConnection(){
        self.label.text=""
        self.xxx.text=""
        self.image.image=nil
        activity.startAnimating();
        println("startConnection");
        
        var restAPI: String = "http://api.openweathermap.org/data/2.5/weather?q=Taipei"
        var url: NSURL = NSURL(string: restAPI)
        var request: NSURLRequest = NSURLRequest(URL: url)
        var connection: NSURLConnection = NSURLConnection(request: request, delegate: self, startImmediately: true)
        
        var json = NSString(data: self.data, encoding : NSUTF8StringEncoding )
        
        println(json)
        
        }
}

