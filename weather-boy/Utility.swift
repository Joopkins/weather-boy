//
//  Utility.swift
//  weather-boy
//
//  Created by Barry Bryant on 8/30/16.
//  Copyright © 2016 Barry Bryant. All rights reserved.
//

import Foundation

func kelvinToFarenheit(temperatureInKelvin: Double) -> Double {
    let kelvinToFarenheitPreDivision = (temperatureInKelvin * (9/5)) - 459.67
    let farenheitTemperature = Double(round(10 * kelvinToFarenheitPreDivision/10))
    return farenheitTemperature
}
