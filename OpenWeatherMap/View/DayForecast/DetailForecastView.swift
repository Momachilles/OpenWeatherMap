//
//  DetailForecastView.swift
//  OpenWeatherMap
//
//  Created by David Alarcon on 17/4/24.
//

import SwiftUI

struct DetailForecastView: View {
  var forecast: FiveDaysForecast.Forecast

  var body: some View {
    List {
      Section {
        HStack {
          AsyncIconView(iconName: forecast.weather[.zero].icon)
          VStack {
            HStack {
              Spacer()
              Text(forecast.main.temp.temperatureString)
                .font(.system(size: 60))
              Spacer()
            }
            Text(forecast.weather.map { $0.main }.joined(separator: " | "))
            HStack {
              Spacer()
              Text("Mn: \(forecast.main.temp_min.temperatureString)")
              Text("Mx: \(forecast.main.temp_max.temperatureString)")
              Spacer()
            }
          }
          .fixedSize()
        }
      }
      .background(Color.clear)
      Section("Pressure") {
        VStack {
          HStack {
            Spacer()
            Text(forecast.main.pressure.pressureString)
              .font(.title)
            Spacer()
          }
          HStack {
            Spacer()
            Text("Sea: \(forecast.main.sea_level.pressureString)")
            Text("Ground: \(forecast.main.grnd_level.pressureString)")
            Spacer()
          }
        }
      }
      .headerProminence(.increased)
      Section("Humidity:") {
        VStack {
          HStack {
            Spacer()
            Text(forecast.main.humidity.humnidityString)
            Spacer()
          }
          .font(.title2)
        }
      }
      .headerProminence(.increased)
      Section("Wind") {
        VStack {
          HStack {
            Text("Speed: \(forecast.wind.speed.speedString)")
            Spacer()
            Text("Degrees: \(forecast.wind.deg.degreesString)")
          }
          .font(.title3)
        }
      }
      .headerProminence(.increased)
      if let visibility = forecast.visibility?.distanceString {
        Section("Visibility") {
          VStack {
            HStack {
              Spacer()
              Text(visibility)
              Spacer()
            }
            .font(.title2)
          }
        }
        .headerProminence(.increased)
      }
    }
    .listStyle(.insetGrouped)
  }
}

#Preview("First forecast") {
  if let forecast = try? DummyFiveDaysForecastLoader.loadDummyForecast().list.first {
    return DetailForecastView(forecast: forecast)
      .environment(OpenWeatherMapClient(networkService: NetworkService()))
  } else { return Text("Something went wrong.") }
}

#Preview("Second forecast") {
  if let forecast = try? DummyFiveDaysForecastLoader.loadDummyForecast().list[1] {
    return DetailForecastView(forecast: forecast)
      .environment(OpenWeatherMapClient(networkService: NetworkService()))
  } else { return Text("Something went wrong.") }
}
