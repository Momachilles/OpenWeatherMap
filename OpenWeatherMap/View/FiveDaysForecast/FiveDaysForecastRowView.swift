//
//  FiveDaysForecastRowView.swift
//  OpenWeatherMap
//
//  Created by David Alarcon on 17/4/24.
//

import SwiftUI

struct FiveDaysForecastRowView: View {
  var forecast: FiveDaysForecast.Forecast
  
  var body: some View {
    HStack(alignment: .center) {
      Text(forecast.dt.timeString)
      Spacer()
      HStack(spacing: .zero) {
        ForEach(forecast.weather, id:\.id) { weather in
          AsyncIconView(iconName: weather.icon)
            .frame(maxWidth: 50, minHeight: 50)
        }
      }
      Spacer()
      Text("\(Int(forecast.main.temp)) ºC")
    }
  }
}

/*
#Preview {
  FiveDaysForecastRowView(forecast: )
} */
