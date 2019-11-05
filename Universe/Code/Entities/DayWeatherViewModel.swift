//
//  DayWeatherViewModel.swift
//  Universe
//
//  Created by Andrey Maksymov on 10/3/19.
//  Copyright © 2019 Andrey Maksymov. All rights reserved.
//

import UIKit
import SDWebImage

private let imagesUrlString = "https://darksky.net/images/weather-icons/"
private let imagesExtensionString = ".png"

class DayWeatherViewModel {
    private var dayWeather: DayWeather
    
    init(_ newDayWeather: DayWeather) {
        dayWeather = newDayWeather
    }
    
    var maxTempString: String {
        return "\(maxTemp) C"
    }
    
    var minTempString: String {
        return "\(minTemp) C"
    }
    
    var windSpeedString: String {
        guard let windSpeed = dayWeather.windSpeed else {
            return ""
        }
        return "\(windSpeed) km/h"
    }
    
    var iconUrl: URL? {
        guard let icon = dayWeather.icon, let url = URL(string: "\(imagesUrlString)\(icon)\(imagesExtensionString)") else {
            return nil
        }
        return url
    }
    
    var stringDate: String {
        guard let date = dayWeather.date else {
            return ""
        }
        return date.stringFromDate()
    }
    
    var summary: String {
        return dayWeather.summary ?? ""
    }
    
    var maxTemp: Int {
        return dayWeather.maxTemp ?? 0
    }
    
    var minTemp: Int {
        return dayWeather.minTemp ?? 0
    }
}
