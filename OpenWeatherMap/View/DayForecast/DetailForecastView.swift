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
      Text("Hello")
    }
    .navigationTitle(forecast.dt.forecastDateFormatted)
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
