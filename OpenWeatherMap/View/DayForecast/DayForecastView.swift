//
//  DayForecastView.swift
//  OpenWeatherMap
//
//  Created by David Alarcon on 17/4/24.
//

import SwiftUI

struct DayForecastView: View {
  var forecast: FiveDaysForecast.Forecast

  var body: some View {
    List {
      Text("Hello")
    }
    .navigationTitle(forecast.dt.forecastDateFormatted)
  }
}

/*
 #Preview {
 DayForecastView()
 } */