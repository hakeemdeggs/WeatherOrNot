//
//  WeatherModel.swift
//  WeatherOrNot
//
//  Created by Hakeem Deggs on 3/27/22.
//

import Foundation


struct WeatherModel {
    
    let conditionId: Int
    let cityName: String
    let temp: Double
    
    var temperatureString: String {
       
        let temperature = String(format: "%.0f", temp)
        return temperature
    }
    
    
    var conditionName: String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt.rain"
        case 300...321 :
            return "cloud.drizzle.fill"
        case 500...531:
            return "cloud.rain.fill"
        case 600...622:
            return "cloud.snow.fill"
        case 701...781:
            return "smoke.fill"
        case 800:
            return "sun.max.fill"
        case 801...804:
            return "cloud.fill"
        default:
            return "cloud.fill"
        }
    }
}
