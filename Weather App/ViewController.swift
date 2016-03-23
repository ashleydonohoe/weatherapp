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
        var editedCity = searchbox.text!
        if editedCity.containsString(" ") == true {
            editedCity = editedCity.componentsSeparatedByString(" ").joinWithSeparator("")
        }
        
        var wasSuccessful = false
        print("Getting Data for \(city)")
        
        let attemptedUrl = NSURL(string:"http://www.weather-forecast.com/locations/\(editedCity)/forecasts/latest")
        if let url = attemptedUrl {
        
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) -> Void in
            if let urlContent = data {
                let webContent = NSString(data: urlContent, encoding: NSUTF8StringEncoding)
                let websiteArray = webContent?.componentsSeparatedByString("3 Day Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">")
                if websiteArray!.count > 1 {
                    let weatherArray = websiteArray![1].componentsSeparatedByString("</span>")
                    print(weatherArray[0])
                    if weatherArray.count > 1 {
                        wasSuccessful = true
                        let weatherSummary = weatherArray[0].stringByReplacingOccurrencesOfString("&deg;", withString: "º")
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            self.resultLabel.text = weatherSummary
                        })
                    }
                }
            }
            
            if !wasSuccessful {
                self.resultLabel.text = "Sorry, an error has occurred"
            }
        }
            task.resume()
        } else {
            self.resultLabel.text = "Couldn't find any weather for that city"
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        searchbox.resignFirstResponder()
        return true
    }
}
