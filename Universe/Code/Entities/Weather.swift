//
//  Weather.swift
//  Universe
//
//  Created by Andrey Maksymov on 10/3/19.
//  Copyright © 2019 Andrey Maksymov. All rights reserved.
//

import ObjectMapper

class DayWeather: Mappable {
    
    var date: Date?
    var maxTemp: Int?
    var minTemp: Int?
    var windSpeed: Int?
    var icon: String?
    var summary: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        date        <- (map["time"], DateTransform())
        maxTemp     <- map["temperatureMax"]
        minTemp     <- map["temperatureMin"]
        icon        <- map["icon"]
        summary     <- map["summary"]
        windSpeed   <- map["windSpeed"]
    }
}
