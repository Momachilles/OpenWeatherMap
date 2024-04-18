//
//  NetworkServiceTests.swift
//  OpenWeatherMapTests
//
//  Created by David Alarcon on 18/4/24.
//

import XCTest
import RxSwift
@testable import OpenWeatherMap

final class NetworkServiceTests: XCTestCase {

  func testNetworkServiceWhenSuccessfulResponse() {
    /// Given
    let succesfullMessage = "Test Succesfull"
    guard let response = try? NetworkServiceTests.successfullResponse(with: succesfullMessage) else { return XCTFail("Something went wrong.") }
    MockURLProtocol.mockResponses = response
    let sut = NetworkServiceTests.mockNetworkService()

    /// When
    let expectation = XCTestExpectation(description: "Request completes successfully")
    let single = sut.request(from: DummyEndpoint()) as Single<DummyTestModel>

    /// Then
    _ = single.subscribe { event in
      switch event {
      case .success(let response): XCTAssertEqual(response.message, succesfullMessage)
      case .failure(let error): XCTFail("Request failed with error: \(error)")
      }
      expectation.fulfill()
    }

    wait(for: [expectation], timeout: 1.0)
  }

  func testNetworkServiceWhenFailureResponseAsInvalidURL() {
    /// Given
    let sut = NetworkServiceTests.mockNetworkService()

    /// When
    let expectation = XCTestExpectation(description: "Request completes successfully")
    let single = sut.request(from: DummyInvalidURLEndpoint()) as Single<DummyTestModel>

    /// Then
    _ = single.subscribe { event in
      switch event {
      case .success: XCTFail("Request should have failed with invalid URL error")
      case .failure(let error):
        XCTAssertEqual(error as? NetworkError, NetworkError.invalidURL)
      }
      expectation.fulfill()
    }

    wait(for: [expectation], timeout: 1.0)
  }
}

extension NetworkServiceTests {
  static func mockNetworkService() -> NetworkServiceProtocol {
    URLProtocol.registerClass(MockURLProtocol.self)

    let configuration = URLSessionConfiguration.default
    configuration.protocolClasses?.insert(MockURLProtocol.self, at: .zero)

    return NetworkService(configuration: configuration)
  }

  static func successfullResponse(with message: String = "Success") throws -> [URL: (Data?, URLResponse?, Error?)]? {
    guard let url = DummyEndpoint().urlRequest?.url else { throw NetworkError.invalidURL }

    let expectedData = DummyTestModel(message: message).json.data(using: .utf8)
    let expectedResponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)

    return [url: (expectedData, expectedResponse, .none)]
  }

  /*
  static func failureURLResponse() throws -> [URL: (Data?, URLResponse?, Error?)]? {
    guard let url = URL(string: "http://test.com/this/is/a/test") else { throw NetworkError.invalidURL }

    return [url: (.none, .none, NetworkError.invalidURL)]
  } */
}

extension DummyFiveDaysForecastLoader { // TODO: Delete
  static func loadJSONData() throws -> Data? {
    guard let url = Bundle.main.url(forResource: "FiveDaysForecast", withExtension: "json") else {
      throw NSError(domain: "DummyFiveDaysForecastLoader", code: 404, userInfo: [NSLocalizedDescriptionKey: "File not found"])
    }

    return try Data(contentsOf: url)
  }
}

extension NetworkError: Equatable {
  public static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
    switch (lhs, rhs) {
    case
      (.invalidURL, .invalidURL),
      (.invalidResponse, .invalidResponse),
      (.emptyData, .emptyData),
      (.requestFailed, .requestFailed),
      (.invalidJSON, .invalidJSON) : return true
    default: return false
    }
  }
}
