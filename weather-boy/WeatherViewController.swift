//
//  WeatherViewController.swift
//  weather-boy
//
//  Created by Barry Bryant on 8/29/16.
//  Copyright © 2016 Barry Bryant. All rights reserved.
//

import UIKit
import Alamofire

class WeatherViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currentTemperature: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentWeatherTypeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var currentWeather: CurrentWeather!
    var forecast: Forecast!
    var forecasts: [Forecast]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        currentWeather = CurrentWeather()
        forecasts = [Forecast]()
        currentWeather.downloadWeatherDetails {
            self.updateCurrentWeather()
            self.downloadForecastData {
                print(";)")
            }
        }
    }
    
    func downloadForecastData(completed: DownloadComplete) {
        //downloading forecast weather data for tableview
        let forecastURL = URL(string: FORECAST_URL)
        Alamofire.request(forecastURL!, withMethod: .get).responseJSON { response in
            if let dictionary = response.result.value as? Dictionary<String, AnyObject> {
                if let list = dictionary["list"] as? [Dictionary<String, AnyObject>] {
                    for object in list {
                        let forecast = Forecast(weatherDictionary: object)
                        self.forecasts.append(forecast)
                    }
                }
            }
            self.tableView.reloadData()
        }
        completed()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell {
            let forecast = forecasts[indexPath.row]
            cell.configureCell(forecast: forecast)
            return cell
        } else {
            return WeatherCell()
        }
    }
    
    func updateCurrentWeather() {
        dateLabel.text = currentWeather.date
        currentTemperature.text = "\(currentWeather.currentTemperature)" 
        currentWeatherTypeLabel.text = currentWeather.weatherType
        locationLabel.text = currentWeather.cityName
        currentWeatherImage.image = UIImage(named: currentWeather.weatherType)
    }




}

