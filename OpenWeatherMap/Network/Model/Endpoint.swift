//
//  Endpoint.swift
//  OpenWeatherMap
//
//  Created by David Alarcon on 15/4/24.
//

import Foundation

enum Method: String {
  case get = "GET"
  
  var string: String { rawValue }
}

protocol Endpoint {
  var scheme: String { get }
  var host: String { get }
  var baseURLString: String { get }
  var path: String { get }
  var method: Method { get }
  var queryParameters: [String: String] { get }
}

protocol URLRequestable {
  var urlRequest: URLRequest? { get }
}

protocol OpenWeatherMapEndpoint: Endpoint, URLRequestable {}
extension OpenWeatherMapEndpoint {
  var scheme: String { "http" }
  var host: String { "api.openweathermap.org" }
  var baseURLString: String { "data/2.5" }
}

struct FiveDaysForecastEndpoint: OpenWeatherMapEndpoint {
  var city: String
  var path: String { "forecast" }
  var queryParameters: [String : String] { ["q": city, "appid": "73d4241c301a36ae37bcf003d9c78279"] }
  var method: Method { .get }
  
  var urlRequest: URLRequest? {
    var components = URLComponents()
    components.scheme = scheme
    components.host = host
    components.path = baseURLString + "/" + path
    components.queryItems = queryParameters.map { URLQueryItem(name: $0.key, value: $0.value) }
    
    guard let url = components.url else { return .none }
    
    var request = URLRequest(url: url)
    request.httpMethod = method.string
    
    return request
  }
}
