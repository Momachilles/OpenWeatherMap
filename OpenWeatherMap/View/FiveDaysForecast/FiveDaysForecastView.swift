//
//  FiveDaysForecastView.swift
//  OpenWeatherMap
//
//  Created by David Alarcon on 15/4/24.
//

import SwiftUI

struct FiveDaysForecastView: View {
  private let viewModel: FiveDaysForecastViewModelProtocol
  @State private var city: String = ""
  
  init(viewModel: FiveDaysForecastViewModelProtocol) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    VStack {
      TextField("Enter City", text: $city, onCommit: {
        viewModel.fiveDaysForecast(for: city)
      })
      .padding()
      
      if let weather = viewModel.fiveDaysForecast {
        Text("Temperature: \(weather.list[0].main.temp) °C")
        Text("Humidity: \(weather.list[0].main.humidity) %")
        // Add other weather properties here
      } else {
        Text("No data available")
      }
    }
    .padding()
  }
}

#Preview {
  FiveDaysForecastView(viewModel: FiveDaysForecastViewModel())
}
