//
//  ViewController.swift
//  Weather App
//
//  Created by Gabriele on 3/22/16.
//  Copyright © 2016 Ashley Donohoe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var searchbox: UITextField!
    var city = ""
    var weatherData: String!
    
    @IBOutlet weak var resultLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func getWeatherInfo(sender: UIButton) {
        let editedCity = searchbox.text!
        if editedCity.containsString(" ") == true {
            city = editedCity.componentsSeparatedByString(" ").joinWithSeparator("")
        }
        print(city)
        getData()
    }
    
    func getData() {
        print("Getting Data for \(city)")
        
        let url = NSURL(string:"http://www.weather-forecast.com/locations/\(city)/forecasts/latest")!
        
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) -> Void in
            if let urlContent = data {
                let webContent = NSString(data: urlContent, encoding: NSUTF8StringEncoding)
                let websiteArray = webContent?.componentsSeparatedByString("3 Day Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">")
                if websiteArray!.count > 0 {
                    let weatherArray = websiteArray![1].componentsSeparatedByString("</span>")
                    print(weatherArray[0])
                    if weatherArray.count > 0 {
                        let weatherSummary = weatherArray[0].stringByReplacingOccurrencesOfString("&deg;", withString: "º")
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            self.resultLabel.text = weatherSummary
                        })
                    }
                }
            }
        }
        task.resume()
    }
}
