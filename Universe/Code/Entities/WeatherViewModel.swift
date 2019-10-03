//
//  WeatherViewModel.swift
//  Universe
//
//  Created by Andrey Maksymov on 10/3/19.
//  Copyright © 2019 Andrey Maksymov. All rights reserved.
//

import UIKit
import Bond

class WeatherViewModel {
    let weather = Observable<WeatherResponse?>(nil)
    let dayWeathers = Observable<[DayWeatherViewModel]>([])
    let error = Observable<Error?>(nil)
    let isFetching = Observable<Bool>(false)
    
    func fetch(forPeriod period: PeriodDuration) {
        isFetching.value = true
        WeatherRemote.shared().getDailyWeather(forPeriod: period, succes: { [weak self] (weather) in
            guard let strongSelf = self else { return }
            DispatchQueue.main.async {
                strongSelf.isFetching.value = false
                strongSelf.weather.value = weather
                strongSelf.dayWeathers.value =  weather.weathers.map { DayWeatherViewModel($0) }
            }
        }) { [weak self] (error) in
        guard let strongSelf = self else { return }
            DispatchQueue.main.async {
                strongSelf.isFetching.value = false
                strongSelf.error.value = error
            }
        }
    }
    
    var currentTemp: String {
        guard let weather = weather.value, let temp = weather.currentTemp, let name = weather.timeZone else {return ""}
        return "\(name)\n\(temp) C"
    }
    
    func showCurrentTemp(onLabel label: UILabel) {
        label.text = currentTemp
    }
}
