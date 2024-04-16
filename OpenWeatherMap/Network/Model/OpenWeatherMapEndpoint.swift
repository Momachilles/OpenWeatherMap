//
//  OpenWeatherMapEndpoint.swift
//  OpenWeatherMap
//
//  Created by David Alarcon on 16/4/24.
//

import Foundation

protocol OpenWeatherMapEndpoint: Endpoint, URLRequestable {}
extension OpenWeatherMapEndpoint {
  var scheme: String { "http" }
  var host: String { "api.openweathermap.org" }
  var baseURLString: String { "data/2.5" }
}
