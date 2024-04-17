//
//  FiveDaysForecastDayView.swift
//  OpenWeatherMap
//
//  Created by David Alarcon on 17/4/24.
//

import SwiftUI

struct FiveDaysForecastDayView: View {
  var forecasts: [FiveDaysForecast.Forecast]
  
  var body: some View {
    ForEach(forecasts, id: \.dt) { forecast in
      NavigationLink {
        DayForecastView(forecast: forecast)
      } label: {
        FiveDaysForecastRowView(forecast: forecast)
      }
    }
  }
}

#Preview {
  FiveDaysForecastDayView(forecasts: [])
}