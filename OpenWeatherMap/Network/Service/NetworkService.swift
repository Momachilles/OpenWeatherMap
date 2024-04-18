//
//  NetworkService.swift
//  OpenWeatherMap
//
//  Created by David Alarcon on 15/4/24.
//

import Foundation
import RxSwift
import RxCocoa

enum NetworkError: Error {
  case invalidURL
  case invalidResponse(URLResponse?)
  case emptyData
  case requestFailed(Error)
  case invalidJSON(Error)
}

protocol NetworkServiceProtocol {
  func request<T: Decodable>(from requestConvertible: URLRequestable) -> Single<T>
  func data(from requestConvertible: URLRequestable) -> Single<Data>
}

class NetworkService: NetworkServiceProtocol {
  private let session: URLSession

  init(configuration: URLSessionConfiguration = URLSessionConfiguration.default) {
    self.session = URLSession(configuration: configuration)
  }

  func request<T: Decodable>(from requestConvertible: any URLRequestable) -> Single<T> {
    return Single.create { single in
      guard let urlRequest = requestConvertible.urlRequest else {
        single(.failure(NetworkError.invalidURL))

        return Disposables.create()
      }

      let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
        if let error = error { return single(.failure(NetworkError.requestFailed(error))) }

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
          return single(.failure(NetworkError.invalidResponse(response)))
        }

        guard let data = data, !data.isEmpty else { return single(.failure(NetworkError.emptyData)) }

        do {
          let decodedResponse = try JSONDecoder().decode(T.self, from: data)
          single(.success(decodedResponse))
        } catch let error {
          single(.failure(NetworkError.invalidJSON(error)))
        }
      }

      task.resume()

      return Disposables.create { task.cancel() }
    }
  }

  func data(from requestConvertible: any URLRequestable) -> Single<Data> {
    return Single.create { single in
      guard let urlRequest = requestConvertible.urlRequest else {
        single(.failure(NetworkError.invalidURL))

        return Disposables.create()
      }

      let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
        if let error = error { return single(.failure(NetworkError.requestFailed(error))) }

        guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
          return single(.failure(NetworkError.invalidResponse(response)))
        }

        guard let data = data, !data.isEmpty else { return single(.failure(NetworkError.emptyData)) }

        single(.success(data))
      }

      task.resume()

      return Disposables.create { task.cancel() }
    }
  }
}
