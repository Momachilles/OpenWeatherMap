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
      FiveDaysForecastRowView(forecast: forecast)
        .background {
          NavigationLink(value: forecast) {}
            .opacity(.zero)
        }
    }
  }
}

#Preview {
  FiveDaysForecastDayView(forecasts: [])
}
