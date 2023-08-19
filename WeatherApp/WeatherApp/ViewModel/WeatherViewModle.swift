//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by Diya Alowdah on 16/08/2023.
//
//https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}
import Foundation
import SwiftUI
import CoreLocation

struct WeatherViewModle {
    
    func getCurrentWeather (latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> ResponseBody {
        guard let url = URL(string:"https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\("0e057f4d76017f4111ce5c5fbcfed559")&units=metric") else {
            fatalError ("Missing URL")}
        
        
        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError ("Error fetching weather data") }
        
        
        let decodedData = try JSONDecoder().decode(ResponseBody.self, from: data)
        
        return decodedData
        
    }
    
}

    
    
    


struct ResponseBody: Decodable {
    var coord: CoordinatesResponse
    var weather: [WeatherResponse]
    var main: MainResponse
    var name: String
    var wind: WindResponse
    
    struct CoordinatesResponse: Decodable {
        var lon: Double
        var lat: Double
    }
    
    struct WeatherResponse: Decodable {
        var id: Double
        var main: String
        var description: String
        var icon: String
    }
    
    struct MainResponse: Decodable {
        var temp: Double
        var feels_like: Double
        var temp_min: Double
        var temp_max: Double
        var pressure: Double
        var humidity: Double
    }

    struct WindResponse: Decodable {
        var speed: Double
        var deg: Double
    }
}
    extension ResponseBody.MainResponse {
        var feelsLike: Double { return feels_like}
        
        var tembMin: Double { return temp_min }
        var tempMax: Double { return temp_max }
    }
    

