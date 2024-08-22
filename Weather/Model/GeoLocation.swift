//
//  GeoLocation.swift
//  Weather
//
//  Created by Rambabu Murakonda on 8/21/24.
//

import Foundation

struct Coordinates: Codable {
    let latitude: Double
    let longitude: Double
}

struct GeoLocation: Codable, Identifiable {
    var id: String {
        "\(name),\(state),\(country)"
    }

    var displayName: String {
        "\(name), \(state), \(country)"
    }

    let name: String
    let latitude: Double
    let longitude: Double
    let state: String
    let country: String
    
    enum CodingKeys: String, CodingKey {
        case name, state, country
        case latitude = "lat"
        case longitude = "lon"
    }
}
