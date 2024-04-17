//
//  IconEndpoint.swift
//  OpenWeatherMap
//
//  Created by David Alarcon on 16/4/24.
//

import Foundation

struct WeatherIconEndpoint: OpenWeatherMapEndpoint {
  var icon: String
// https://openweathermap.org/img/wn/10d@2x.png
  var host: String { "openweathermap.org" }
  var baseURLString: String { "/img/wn" }
  var path: String { "/\(icon)@2x.png" }
}
