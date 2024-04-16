//
//  FiveDaysForecastView.swift
//  OpenWeatherMap
//
//  Created by David Alarcon on 15/4/24.
//

import SwiftUI

struct FiveDaysForecastView: View {
  let client = OpenWeatherMapClient(networkService: NetworkService())

  @State private var fiveDaysForecast: FiveDaysForecast?
  @State private var city: String = "Paris"
  @State private var errorMessage: String?

  var body: some View {
    HStack {
      TextField("Enter city", text: $city)
        .padding()
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .autocapitalization(.words)
      
      Button("Fetch Weather") {
        forecast()
      }
      .padding()
    }

    if let errorMessage = errorMessage {
      Text("Error: \(errorMessage)")
        .foregroundColor(.red)
    }

    Spacer()
  }

  private func forecast() {
    Task {
      do {
        fiveDaysForecast = try await client.fiveDaysForecast(for: city)
      } catch {
        errorMessage = error.localizedDescription
      }
    }
  }
}

#Preview {
  FiveDaysForecastView()
}
