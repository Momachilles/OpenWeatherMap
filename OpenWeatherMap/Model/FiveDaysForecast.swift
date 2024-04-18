//
//  FiveDaysForecast.swift
//  OpenWeatherMap
//
//  Created by David Alarcon on 15/4/24.
//

import Foundation

protocol Groupable {
  var groupedList: [(date: String, forecasts: [FiveDaysForecast.Forecast])] { get }
}

struct FiveDaysForecast: Codable {
  let cod: String
  let message: Double
  let cnt: Int
  let list: [Forecast]
  let city: City
  
  struct Forecast: Codable, Hashable {
    
    static func == (lhs: Forecast, rhs: Forecast) -> Bool {
      lhs.dt == rhs.dt
    }
    
    func hash(into hasher: inout Hasher) {
      hasher.combine(dt)
      hasher.combine(dt_txt)
    }
    
    let dt: TimeInterval
    let main: Main
    let weather: [WeatherDescription]
    let clouds: Clouds
    let wind: Wind
    let visibility: Int?
    let pop: Double
    var rain: Rain?
    let snow: Snow?
    let sys: Sys
    let dt_txt: String
    
    struct Main: Codable {
      let temp: Double
      let feels_like: Double
      let temp_min: Double
      let temp_max: Double
      let pressure: Int
      let sea_level: Int
      let grnd_level: Int
      let humidity: Int
      let temp_kf: Double
    }
    
    struct WeatherDescription: Codable {
      let id: Int
      let main: String
      let description: String
      let icon: String
    }
    
    struct Clouds: Codable {
      let all: Int
    }
    
    struct Wind: Codable {
      let speed: Double
      let deg: Int
      let gust: Double
    }
    
    struct Sys: Codable {
      let pod: String
    }
    
    struct Rain: Codable {
      let treeHours: Double
      
      private enum CodingKeys: String, CodingKey {
        case treeHours = "3h"
      }
    }
    
    struct Snow: Codable {
      let treeHours: Double
      
      private enum CodingKeys: String, CodingKey {
        case treeHours = "3h"
      }
    }
  }
  
  struct City: Codable {
    let id: Int
    let name: String
    let coord: Coord
    let country: String
    let population: Int
    let timezone: Int
    let sunrise: TimeInterval
    let sunset: TimeInterval
    
    struct Coord: Codable {
      let lat: Double
      let lon: Double
    }
  }
}

extension FiveDaysForecast: Groupable {
  var groupedList: [(date: String, forecasts: [FiveDaysForecast.Forecast])] {
    var groupedForecasts: [(String, [FiveDaysForecast.Forecast])] = []

    for forecast in list {
      let dayKey = forecast.dt.dateString

      if let index = groupedForecasts.firstIndex(where: { $0.0 == dayKey }) {
        // Append to existing group
        groupedForecasts[index].1.append(forecast)
      } else {
        // Create a new group
        groupedForecasts.append((dayKey, [forecast]))
      }
    }

    return groupedForecasts
  }
}
