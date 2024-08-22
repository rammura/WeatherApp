//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Rambabu Murakonda on 8/21/24.
//

import Foundation
import Combine

@MainActor
class WeatherViewModel: ObservableObject {
    @Published var searchQuery: String
    @Published var searchLocations: [GeoLocation] = []
    @Published var weatherReport: WeatherReport? = nil
    
    enum GeoLocationError: Error {
        case unknown
    }
    
    enum WeatherServiceError: Error {
        case unknown
    }
    
    private var cancellables = Set<AnyCancellable>()
    let locationService: GeoLocatable
    let weatherService: WeatherSearchable
    
    init(searchQuery: String = "",
         locationService: GeoLocatable = GeoLocationService(),
         weatherService: WeatherSearchable = WeatherService()) {
        self.locationService = locationService
        self.weatherService = weatherService
        self.searchQuery = searchQuery
        self.searchLocations = searchLocations
        
        $searchQuery.debounce(for: .seconds(0.75), scheduler: RunLoop.main)
            .removeDuplicates()
            .filter { !$0.isEmpty }
            .flatMap { [unowned self] value in
                return self.locationService.locate(location: value)
                    .mapError { _ in
                        return GeoLocationError.unknown
                    }
            }
            .replaceError(with: [])
            .receive(on: RunLoop.main)
            .assign(to: &$searchLocations)
    }
    
    func fetchWeatherReport(location: Coordinates) {
        self.weatherService.getWeather(for: location)
            .mapError { error in
                print(error.localizedDescription)
                return WeatherServiceError.unknown
            }
            .replaceError(with: nil)
            .receive(on: RunLoop.main)
            .assign(to: &$weatherReport)
    }
}
