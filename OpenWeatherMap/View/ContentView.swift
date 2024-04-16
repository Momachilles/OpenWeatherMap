//
//  ContentView.swift
//  OpenWeatherMap
//
//  Created by David Alarcon on 15/4/24.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    FiveDaysForecastView()
      .environment(OpenWeatherMapClient(networkService: NetworkService()))
  }
}

#Preview {
    ContentView()
}
