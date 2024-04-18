//
//  Int+OpenWeatherMap.swift
//  OpenWeatherMap
//
//  Created by David Alarcon on 18/4/24.
//

import Foundation

extension Int {
  var pressureString: String { "\(self) mmHg" }
  var humnidityString: String { "\(self) %" }
  var degreesString: String { String("\(Int(self)) º") }
  var distanceString: String { "\(Int(Double(self) / 1000.0)) Km" }
}
