//
//  OpenWeatherMapClientTests.swift
//  OpenWeatherMapTests
//
//  Created by David Alarcon on 18/4/24.
//

import XCTest
@testable import OpenWeatherMap

final class OpenWeatherMapClientTests: XCTestCase {

  func testOpenWeatherMapClientFiveDaysForecast() throws {
    let networkService = MockNetworkService()
    let expectedResult = try DummyFiveDaysForecastLoader.loadDummyForecast()
    networkService.requestResult = expectedResult
    let sut = OpenWeatherMapClient(networkService: networkService)
    
    Task {
      let result = try await sut.fiveDaysForecast(for: "London")
      XCTAssertEqual(result, expectedResult)
    }
  }
  
  func testOpenWeatherMapClientData() throws {
    let networkService = MockNetworkService()
    let expectedResult = try XCTUnwrap("Success".data(using: .utf8))
    networkService.requestResult = expectedResult
    let sut = OpenWeatherMapClient(networkService: networkService)
    
    Task {
      let result = try await sut.data(from: "10d")
      XCTAssertEqual(result, expectedResult)
    }
  }
}

extension FiveDaysForecast: Equatable {
  public static func == (lhs: OpenWeatherMap.FiveDaysForecast, rhs: OpenWeatherMap.FiveDaysForecast) -> Bool {
    lhs.cod == rhs.cod
  }
}
