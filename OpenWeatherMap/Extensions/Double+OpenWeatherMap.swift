//
//  Double+OpenWeatherMap.swift
//  OpenWeatherMap
//
//  Created by David Alarcon on 18/4/24.
//

import Foundation

extension Double {
  var temperatureString: String { String("\(Int(self)) ºC") }
  var speedString: String { "\(self) m/s" }
}
