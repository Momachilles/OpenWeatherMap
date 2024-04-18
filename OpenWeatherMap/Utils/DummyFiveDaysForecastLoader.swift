//
//  DummyFiveDaysForecastLoader.swift
//  OpenWeatherMap
//
//  Created by David Alarcon on 17/4/24.
//

import Foundation

class DummyFiveDaysForecastLoader {
  static func loadDummyForecast() throws -> FiveDaysForecast {
    guard let url = Bundle.main.url(forResource: "FiveDaysForecast", withExtension: "json") else {
      throw NSError(domain: "DummyFiveDaysForecastLoader", code: 404, userInfo: [NSLocalizedDescriptionKey: "File not found"])
    }

    let data = try Data(contentsOf: url)
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .secondsSince1970
    return try decoder.decode(FiveDaysForecast.self, from: data)
  }
}
