//
//  OpenWeatherMapClient.swift
//  OpenWeatherMap
//
//  Created by David Alarcon on 15/4/24.
//

import Foundation
import RxSwift

protocol FiveDaysForecastAPI {
  func fiveDaysForecast(for city: String) async throws -> FiveDaysForecast
}

@Observable
class OpenWeatherMapClient {
  private let networkService: NetworkServiceProtocol
  
  init(networkService: NetworkServiceProtocol) {
    self.networkService = networkService
  }
}

extension OpenWeatherMapClient: FiveDaysForecastAPI {
  func fiveDaysForecast(for city: String) async throws -> FiveDaysForecast {
    try await networkService.request(from: FiveDaysForecastEndpoint(city: city)).value
  }

  func data(from icon: String) async throws -> Data {
    try await networkService.data(from: WeatherIconEndpoint(icon: icon)).value
  }
}
