//
//  WeatherManager.swift
//  WeatherOrNot
//
//  Created by Hakeem Deggs on 3/27/22.
//

import Foundation
import CoreLocation
protocol WeatherManagerDelegate {
    func didUpdateWeather(weather:WeatherModel)
}
struct WeatherManager {
    
    var delegate:WeatherManagerDelegate?
    
    let weatherURL =
    "https://api.openweathermap.org/data/2.5/weather?appid=7497819c019f64b5d6ea4d15bd9e8970&units=imperial"
    
    func fetchWeather(cityName: String) {
        
        let urlString = "\(weatherURL)&q=\(cityName)"
        
        performRequest(urlString: urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude:CLLocationDegrees ) {

     let weatherURL = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(urlString: weatherURL)
    }
    
    func performRequest(urlString:String) {
        //Steps to networking
        //1. Create URL
        
        if let url = URL(string: urlString){
            
            //2. Create a URLsession
            
            let session = URLSession(configuration: .default)
            
            //3.Give the session a task
            
            let task = session.dataTask(with: url) { data, urlResponse, error in
                
                if let e = error {
                    print("🤬 error: \(e)")
                    return
                }
                
                if let safeData = data {
                    
                    if let weather = self.parseJSON(weatherData: safeData) {
                        delegate?.didUpdateWeather(weather:weather)
                    }
                }
            }
            
            //4.Start the task
            task.resume()
        }
    }
    
    func parseJSON(weatherData: Data) -> WeatherModel? {
        
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id =  decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            let weather = WeatherModel(conditionId: id, cityName: name, temp: temp)
        
            return weather
        }
        catch{
            print(error)
            return nil
        }
    }
}
