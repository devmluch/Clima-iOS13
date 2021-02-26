//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate, WeatherManagerDelegate {
    

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    var weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherManager.delegate = self
        searchTextField.delegate = self
    }

    @IBAction func seachPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(textField.text!)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTextField.text{
            print("testing")
            weatherManager.fetchWeather(cityName: city)
        }
        searchTextField.text = ""
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Required"
            return false
        }
    }
    func didUpdateWeather (_ weatherManager: WeatherManager, weather: WeatherModel){
        
    }
    
}

