//
//  WeatherService.swift
//  Weather
//
//  Created by Rambabu Murakonda on 8/21/24.
//

import Foundation
import Combine

protocol WeatherSearchable {
    func getWeather(for location: Coordinates) -> AnyPublisher<WeatherReport?, Error>
}

final class WeatherService: WeatherSearchable {
    
    private var api: WeatherAPI
    
    init(api: any APIClientProtocol = WeatherAPI()) {
        self.api = api as! WeatherAPI
    }
    
    func getWeather(for location: Coordinates) -> AnyPublisher<WeatherReport?, any Error> {
        guard let url = self.api.makeUrl(request: location) else {
            return Fail(error: ServiceError.invalidUrl).eraseToAnyPublisher()
        }
        return self.api.get(url: url)
    }
}
