//
//  GeocodeService.swift
//  Weather
//
//  Created by Rambabu Murakonda on 8/21/24.
//

import Foundation
import Combine

protocol GeoLocatable {
    func locate(location: String) -> AnyPublisher<[GeoLocation], Error>
}

enum ServiceError: Error {
    case invalidUrl
}

final class GeoLocationService: GeoLocatable {

    private var api: GeoCodeAPI

    init(api: any APIClientProtocol = GeoCodeAPI()) {
        self.api = api as! GeoCodeAPI
    }

    func locate(location: String) -> AnyPublisher<[GeoLocation], any Error> {
        guard let url = self.api.makeUrl(request: location) else {
            return Fail(error: ServiceError.invalidUrl).eraseToAnyPublisher()
        }
        return self.api.get(url: url)
    }
}
