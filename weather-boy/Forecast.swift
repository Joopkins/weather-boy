//
//  Forecast.swift
//  weather-boy
//
//  Created by Barry Bryant on 8/30/16.
//  Copyright © 2016 Barry Bryant. All rights reserved.
//

import UIKit
import Alamofire

class Forecast {

    private var _date: String!
    private var _weatherType: String!
    private var _highTemperature: Double!
    private var _lowTemperature: Double!
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var highTemperature: Double {
        if _highTemperature == nil {
            _highTemperature = 0.0
        }
        return _highTemperature
    }
    
    var lowTemperature: Double {
        if _lowTemperature == nil {
            _lowTemperature = 0.0
        }
        return _lowTemperature
    }
    
    init(weatherDictionary: Dictionary<String, AnyObject>) {
        if let temperature = weatherDictionary["temp"] as? Dictionary<String, AnyObject> {
            if let min = temperature["min"] as? Double {
                self._lowTemperature = kelvinToFarenheit(temperatureInKelvin: min)
            }
            
            if let max = temperature["max"] as? Double {
                self._highTemperature = kelvinToFarenheit(temperatureInKelvin: max)
            }
        }
        
        if let weather = weatherDictionary["weather"] as? [Dictionary<String, AnyObject>] {
            if let main = weather[0]["main"] as? String {
                self._weatherType = main.capitalized
            }
        }
        
        if let date = weatherDictionary["dt"] as? Double {
            let unixConvertedDate = Date(timeIntervalSince1970: date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.dateFormat = .none
            self._date = unixConvertedDate.dayOfTheWeek()
        }
    }
    
    
    
}

extension Date {
    func dayOfTheWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
}
