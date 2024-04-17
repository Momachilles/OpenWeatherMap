//
//  FiveDaysForecastEndpoint.swift
//  OpenWeatherMap
//
//  Created by David Alarcon on 16/4/24.
//

import Foundation

struct FiveDaysForecastEndpoint: OpenWeatherMapEndpoint {
  var city: String
  var path: String { "/forecast" }
  var queryParameters: [String : String]? { ["q": city, "appid": "73d4241c301a36ae37bcf003d9c78279", "units": "metric"] }
}
