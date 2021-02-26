//
//  WeatherManager.swift
//  Clima
//
//  Created by Mateo Luchina on 23/02/2021.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError (error: Error)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=3e5ff2205068cfb72c1fb246cee58c26&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather (cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        //print(urlString)
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String)  {
        
        if let url = URL(string: urlString) {
            
            let session = URLSession( configuration: .default)
            
            
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJson(weatherData: safeData){
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func parseJson(weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp =  decodedData.main.temp
            print(String(format: "%.1f", decodedData.main.temp))
            let name = decodedData.name
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            return weather
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }

    
}
