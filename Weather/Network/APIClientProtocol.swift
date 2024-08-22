//
//  APIClientProtocol.swift
//  Weather
//
//  Created by Rambabu Murakonda on 8/21/24.
//

import Foundation
import Combine

protocol APIClientProtocol {

    associatedtype Request: Codable
    associatedtype Response: Codable

    var urlSession: URLSession { get }
    func makeUrl(request: Request) -> URL?
    func get(url: URL) -> AnyPublisher<Response, Error>
}

extension APIClientProtocol {

    var urlSession: URLSession {
        return URLSession.shared
    }

    func get(url: URL) -> AnyPublisher<Response, any Error> {
        return self.urlSession.dataTaskPublisher(for: url)
            .tryMap() { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return element.data
            }
            .decode(type: Response.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
