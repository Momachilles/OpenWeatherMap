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


class OpenWeatherMapClient {
  private let networkService: NetworkServiceProtocol
  
  init(networkService: NetworkServiceProtocol) {
    self.networkService = networkService
  }
}

extension OpenWeatherMapClient: FiveDaysForecastAPI {
  func fiveDaysForecast(for city: String) async throws -> FiveDaysForecast {
    try await networkService.request(FiveDaysForecastEndpoint(city: city)).value
  }
}
