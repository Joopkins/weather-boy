//
//  WeatherCell.swift
//  weather-boy
//
//  Created by Barry Bryant on 8/30/16.
//  Copyright © 2016 Barry Bryant. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var highLabel: UILabel!
    @IBOutlet weak var lowLabel: UILabel!
    
    func configureCell(forecast: Forecast) {
        lowLabel.text = "\(forecast.lowTemperature)"
        highLabel.text = "\(forecast.highTemperature)"
        typeLabel.text = forecast.weatherType
        dayLabel.text = forecast.date
        weatherIcon.image = UIImage(named: forecast.weatherType)
        
    }


}
