//
//  NetworkService.swift
//  OpenWeatherMap
//
//  Created by David Alarcon on 15/4/24.
//

import Foundation
import RxSwift

enum NetworkError: Error {
  case invalidURL
  case invalidResponse
  case requestFailed(Error)
}

protocol NetworkServiceProtocol {
  func request<T: Decodable>(_ endpoint: URLRequestable, responseType: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
  func request<T: Decodable>(_ endpoint: URLRequestable, responseType: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void) {
    guard let urlRequest = endpoint.urlRequest else {
      completion(.failure(.invalidURL))
      return
    }
    
    URLSession.shared.dataTask(with: urlRequest) { data, response, error in
      guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
        return completion(.failure(.invalidResponse))
      }
      
      if let error = error { return completion(.failure(.requestFailed(error))) }
      guard let data = data else { return completion(.failure(.invalidResponse)) }
      
      do {
        let decodedResponse = try JSONDecoder().decode(T.self, from: data)
        completion(.success(decodedResponse))
      } catch {
        completion(.failure(.invalidResponse))
      }
    }.resume()
  }
}
