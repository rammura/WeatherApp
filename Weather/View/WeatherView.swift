//
//  WeatherView.swift
//  Weather
//
//  Created by Rambabu Murakonda on 8/21/24.
//

import SwiftUI

struct WeatherView: View {
    
    @StateObject var weatherReport: WeatherReport
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(weatherReport.dt.toDate().toString())
                .foregroundStyle(Color(hex: "#eb6e4b"))
            Text("\(weatherReport.name), \(weatherReport.sys.country)")
                .font(.title)
                .fontWeight(.bold)
            HStack {
                Text("\(weatherReport.main.temp.formatted())\(Locale.current.tempUnits)")
                    .font(.title2)
                VStack {
                    HStack {
                        Text("weather.result.temp.min")
                        Text("\(weatherReport.main.tempMin.formatted())\(Locale.current.tempUnits)")
                    }
                    HStack {
                        Text("weather.result.temp.max")
                        Text("\(weatherReport.main.tempMax.formatted())\(Locale.current.tempUnits)")
                    }
                }
            }
            HStack {
                Text("weather.result.temp.feelslike")
                Text("\(weatherReport.main.feelsLike.formatted())\(Locale.current.tempUnits)")
            }
            HStack {
                Text("weather.result.humidity")
                Text("\(weatherReport.main.humidity)%")
            }
            Spacer()
        }.padding(.top, 10)
    }
}
