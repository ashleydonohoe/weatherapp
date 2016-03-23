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
        print(url)
    }
}

