//
//  GeoCodeAPI.swift
//  Weather
//
//  Created by Rambabu Murakonda on 8/21/24.
//

import Foundation

final class GeoCodeAPI: APIClientProtocol {

    typealias Request = String
    typealias Response = [GeoLocation]

    func makeUrl(request: String) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.openweathermap.org"
        components.path = "/geo/1.0/direct"
        components.queryItems = [
            URLQueryItem(name: "q", value: request),
            URLQueryItem(name: "limit", value: "5"),
            URLQueryItem(name: "appid", value: "3a224bc60a556917ad1ca3707a8b016f"),
        ]
        
        return components.url
    }
}
