//
//  WeatherAPI.swift
//  Weather
//
//  Created by Rambabu Murakonda on 8/21/24.
//

import Foundation

final class WeatherAPI: APIClientProtocol {
    typealias Request = Coordinates
    typealias Response = WeatherReport?
    
    func makeUrl(request: Coordinates) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.openweathermap.org"
        components.path = "/data/2.5/weather"
        components.queryItems = [
            URLQueryItem(name: "lat", value: "\(request.latitude)"),
            URLQueryItem(name: "lon", value: "\(request.longitude)"),
            URLQueryItem(name: "units", value: "\(Locale.current.measurementSystem)"),
            URLQueryItem(name: "appid", value: "3a224bc60a556917ad1ca3707a8b016f"),
        ]
        
        return components.url
    }
}
