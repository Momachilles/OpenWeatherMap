//
//  MockNetworkService.swift
//  OpenWeatherMapTests
//
//  Created by David Alarcon on 18/4/24.
//

import Foundation
import RxSwift
@testable import OpenWeatherMap

class MockNetworkService: NetworkServiceProtocol {

  var requestResult: Decodable?
  var dataResult: Data?

  func request<T: Decodable>(from requestConvertible: URLRequestable) -> Single<T> {
    Single.create { single in
      if let result = self.requestResult as? T { single(.success(result)) }
      else { single(.failure(NetworkError.invalidResponse(.none))) }

      return Disposables.create()
    }
  }

  func data(from requestConvertible: URLRequestable) -> Single<Data> {
    Single.create { single in
      if let result = self.dataResult { single(.success(result))
      } else { single(.failure(NetworkError.invalidResponse(.none))) }

      return Disposables.create()
    }
  }
}
