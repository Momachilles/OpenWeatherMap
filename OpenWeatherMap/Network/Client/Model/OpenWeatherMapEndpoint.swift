//
//  OpenWeatherMapEndpoint.swift
//  OpenWeatherMap
//
//  Created by David Alarcon on 16/4/24.
//

import Foundation

protocol OpenWeatherMapEndpoint: Endpoint, URLRequestable {}

extension OpenWeatherMapEndpoint {
  var scheme: String { "https" }
  var host: String { "api.openweathermap.org" }
  var baseURLString: String { "/data/2.5" }
  var queryParameters: [String : String]? { .none }
  var method: Method { .get }

  var urlRequest: URLRequest? {
    var components = URLComponents()
    components.scheme = scheme
    components.host = host
    components.path = baseURLString + path
    components.queryItems = queryParameters?.map { URLQueryItem(name: $0.key, value: $0.value) }

    guard let url = components.url else { return .none }

    var request = URLRequest(url: url)
    request.httpMethod = method.string

    return request
  }
}
