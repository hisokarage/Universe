//
//  TestWeatherRemote.swift
//  UniverseTests
//
//  Created by Andrey Maksymov on 21.10.2019.
//  Copyright © 2019 Andrey Maksymov. All rights reserved.
//

import XCTest
@testable import Universe

import ObjectMapper

class TestWeatherRemote: XCTestCase {
    
    let period: PeriodDuration = .days3
    
    func testGetDailyWeather() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let promise = expectation(description: "Fetch daily weather")
        
        WeatherRemote.shared().getDailyWeather(forPeriod: period, succes: { (weatherResponse) in
            XCTAssertNotNil(weatherResponse)
            for w in weatherResponse.weathers {
                print(w.maxTemp as Any)
            }
            
            XCTAssertEqual(weatherResponse.weathers.count, self.period.rawValue, "weathers count are not equal to request period")
            
            promise.fulfill()
        }) { (error) in
            XCTFail(error.localizedDescription)
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 60)
    }
    
    
//    func testDayWeatherInitialization() {
//        
//        let sampleJSON = [
//                  "time" : "2019-10-20 21:00:00 +0000",
//                  "temperatureMin": 5,
//                  "temperatureMax": 17,
//                  "icon": "fog",
//                  "summary": "Kiev",
//                  "windSpeed": 2
//            ] as [String : Any]
//        
//        let weather = Mapper<DayWeather>().map(JSON: sampleJSON)
//        
//        XCTAssertEqual(weather?.minTemp, 5)
//        XCTAssertEqual(weather?.maxTemp, 17)
//        XCTAssertEqual(weather?.icon, "fog")
//        XCTAssertEqual(weather?.summary, "Kiev")
//        XCTAssertEqual(weather?.windSpeed, 2)
//    }

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
        }
    }

}
