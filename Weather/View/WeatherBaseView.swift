//
//  WeatherBaseView.swift
//  Weather
//
//  Created by Rambabu Murakonda on 8/21/24.
//

import SwiftUI

struct WeatherBaseView: View {

    @AppStorage("current.location.coordinates.lat") var latitude: Double = .nan
    @AppStorage("current.location.coordinates.long") var longitude: Double = .nan

    @StateObject var viewModel: WeatherViewModel = .init()

    var body: some View {
        VStack {
            HStack {
                TextField("weather.search.input.label", text: $viewModel.searchQuery)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.secondary)
            }.padding()
                .clipShape(RoundedRectangle(cornerRadius: 10.0))
                .overlay {
                    RoundedRectangle(cornerRadius: 10.0)
                        .stroke()
                }

            if !viewModel.searchLocations.isEmpty {
                List(viewModel.searchLocations) { location in
                    Text(location.displayName)
                        .onTapGesture {
                            viewModel.searchQuery = ""
                            viewModel.searchLocations = []
                            latitude = location.latitude
                            longitude = location.longitude
                            fetchWeather()
                        }
                }.scrollContentBackground(.hidden)
            } else if let report = viewModel.weatherReport {
                WeatherView(weatherReport: report)
            } else {
                Spacer()
            }
        }
        .padding()
        .onAppear {
            guard latitude != .nan && longitude != .nan else { return }
            fetchWeather()
        }
    }

    private func fetchWeather() {
        let coordinates = Coordinates(latitude: latitude,
                                      longitude: longitude)
        viewModel.fetchWeatherReport(location: coordinates)
    }
}

#Preview {
    WeatherBaseView()
}
