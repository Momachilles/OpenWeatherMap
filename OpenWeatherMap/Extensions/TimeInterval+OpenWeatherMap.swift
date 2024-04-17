//
//  TimeInterval+OpenWeatherMap.swift
//  OpenWeatherMap
//
//  Created by David Alarcon on 17/4/24.
//

import Foundation

extension TimeInterval {
  var forecastDateFormatted: String {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .short

    return formatter.string(from: Date(timeIntervalSince1970: self))
  }

  var dateString: String {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .none

    return formatter.string(from: Date(timeIntervalSince1970: self))
  }

  var timeString: String {
    let formatter = DateFormatter()
    formatter.dateStyle = .none
    formatter.timeStyle = .short

    return formatter.string(from: Date(timeIntervalSince1970: self))
  }
}
