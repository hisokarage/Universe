//
//  WeatherResponse.swift
//  Universe
//
//  Created by Andrey Maksymov on 10/3/19.
//  Copyright © 2019 Andrey Maksymov. All rights reserved.
//

import ObjectMapper

enum PeriodDuration : Int {
    case days3 = 3;
    case days5 = 5;
    case week = 7
}

class WeatherResponse: Mappable {
    
    var timeZone: String?
    var currentTemp: Int?
    var weathers = [DayWeather]()
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        timeZone    <- map["timezone"]
        currentTemp <- map["currently.temperature"]
        weathers    <- map["daily.data"]
    }
}
