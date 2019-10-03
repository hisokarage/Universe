//
//  WeatherRemote.swift
//  Universe
//
//  Created by Andrey Maksymov on 10/3/19.
//  Copyright © 2019 Andrey Maksymov. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper

private let APIKey = "6afb2a43d9bb7ff52d72879af87f6906"
private let kievkCoords = "50.2716,30.3125"

private let baseWeatherUrl = "https://api.darksky.net/forecast/\(APIKey)/\(kievkCoords)"

public class WeatherRemote  {
    private static var sharedWRemote: WeatherRemote = {
        let sharedRemoteMgr = WeatherRemote(baseURL: URL(string: "https://api.fleetwatcher.com")!)
        
        return sharedRemoteMgr
    }()
    
    let baseURL: URL
    
    private init(baseURL: URL) {
        self.baseURL = baseURL
    }
    
    class func shared() -> WeatherRemote {
        return sharedWRemote
    }
    
    func getDailyWeather(forPeriod period: PeriodDuration, succes : @escaping (WeatherResponse) -> Void, failure : @escaping (Error) -> Void) {
        let params = [
            "exclude" : ["minutely", "hourly", "alerts", "flags"].joined(separator: ","),
            "units": ["si"].joined(separator: ","),
            ] as Parameters
        
        Alamofire.request(baseWeatherUrl, method: .get, parameters: params, encoding: URLEncoding.methodDependent, headers: nil).responseObject { (response: DataResponse<WeatherResponse>) in
            switch response.result {
            case .success(let value):
                value.weathers = Array(value.weathers.prefix(period.rawValue)) // filter weathers for needed period
                succes(value)
            case .failure(let error):
                failure(error)
            }
        }
    }
}
