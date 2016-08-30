//
//  CurrentWeather.swift
//  weather-boy
//
//  Created by Barry Bryant on 8/30/16.
//  Copyright © 2016 Barry Bryant. All rights reserved.
//

import UIKit
import Alamofire

class CurrentWeather {
    private var _cityName: String!
    private var _date: String!
    private var _weatherType: String!
    private var _currentTemperature: Double!
    
    var cityName: String {
        if _cityName == nil {
            _cityName = ""
        }
        return _cityName
    }
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        
        let currentDate = dateFormatter.string(from: Date())
        self._date = "Today, \(currentDate)"
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var currentTemperature: Double {
        if _currentTemperature == nil {
            _currentTemperature = 0.0
        }
        return _currentTemperature
    }
    
    func downloadWeatherDetails(completed: DownloadComplete) {
        //Alamofire download
        let currentWeatherUrl = URL(string: CURRENT_WEATHER_URL)!
        Alamofire.request(currentWeatherUrl, withMethod: .get).responseJSON { response in
            if let dictionary = response.result.value as? Dictionary<String, AnyObject> {
                if let name = dictionary["name"] as? String {
                    self._cityName = name.capitalized
                }
                if let weather = dictionary["weather"] as? [Dictionary<String, AnyObject>] {
                    if let main = weather[0]["main"] as? String {
                        self._weatherType = main.capitalized
                    }
                }
                if let main = dictionary["main"] as? Dictionary<String, AnyObject> {
                    if let currentTemperature = main["temp"] as? Double {
                        self._currentTemperature = kelvinToFarenheit(temperatureInKelvin: currentTemperature)
                    }
                }
            }
            completed()
        }
    }
}
