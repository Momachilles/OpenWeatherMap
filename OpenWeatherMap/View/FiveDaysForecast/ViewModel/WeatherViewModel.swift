//
//  WeatherViewModel.swift
//  OpenWeatherMap
//
//  Created by David Alarcon on 15/4/24.
//

import Foundation

protocol FiveDaysForecastViewModelProtocol {
  var fiveDaysForecast: FiveDaysForecast? { get }
  func fiveDaysForecast(for city: String)
}

class FiveDaysForecastViewModel: FiveDaysForecastViewModelProtocol {
  var fiveDaysForecast: FiveDaysForecast?
  
  func fiveDaysForecast(for city: String) {
    fiveDaysForecast = FiveDaysForecast(cod: "", message: .zero, cnt: .zero, list: [], city: .init(id: .zero, name: "", coord: .init(lat: .zero, lon: .zero), country: "", population: .zero, timezone: .zero, sunrise: .zero, sunset: .zero))
  }
}
