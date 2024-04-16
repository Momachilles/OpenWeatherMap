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
  case invalidResponse(URLResponse)
  case requestFailed(Error)
  case invalidJSON(Error)
}

protocol NetworkServiceProtocol {
  func request<T: Decodable>(_ requestConvertible: URLRequestable) -> Observable<T>
}

class NetworkService: NetworkServiceProtocol {
  func request<T: Decodable>(_ requestConvertible: URLRequestable) -> Observable<T> {
    guard let urlRequest = requestConvertible.urlRequest else {
      return Observable.error(NetworkError.invalidURL)
    }
    
    /*
    return URLSession.shared.rx.response(request: urlRequest)
      .map { response, data in
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
          throw NetworkError.invalidResponse
        }
        return data
      }
      .map { data in
        do {
          return try JSONDecoder().decode(T.self, from: data)
        } catch {
          throw NetworkError.invalidResponse
        }
      }
      .catch { error in
        return Observable.error(NetworkError.requestFailed(error))
      } */
    return URLSession.shared.rx.response(request: urlRequest)
      .map { result -> Data in
        guard result.response.statusCode == 200 else {
          throw NetworkError.invalidResponse(result.response)
        }
        return result.data
      }.map { data in
        do {
          let posts = try JSONDecoder().decode(
            T.self, from: data
          )
          return posts
        } catch let error {
          throw NetworkError.invalidJSON(error)
        }
      }
      .observe(on: MainScheduler.instance)
      .asObservable()
  }
}
