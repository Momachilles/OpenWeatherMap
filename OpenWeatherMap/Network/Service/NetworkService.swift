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
  // Add more cases as needed
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
        completion(.failure(.invalidResponse))
        return
      }
      
      if let error = error {
        completion(.failure(.requestFailed(error)))
        return
      }
      
      guard let data = data else {
        completion(.failure(.invalidResponse))
        return
      }
      
      do {
        let decodedResponse = try JSONDecoder().decode(T.self, from: data)
        completion(.success(decodedResponse))
      } catch {
        completion(.failure(.invalidResponse))
      }
    }.resume()
  }
}
