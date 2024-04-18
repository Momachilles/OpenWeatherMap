//
//  FiveDaysForecastView.swift
//  OpenWeatherMap
//
//  Created by David Alarcon on 15/4/24.
//

import SwiftUI

struct FiveDaysForecastView: View {
  @Environment(OpenWeatherMapClient.self) private var api

  enum ViewState {
    case start
    case loading
    case error(_ errorMessage: String)
    case forecast(_ data: FiveDaysForecast)
  }

  @State private var viewState: ViewState = .start
  @State private var city: String = "Paris"

  var body: some View {
    NavigationStack {
      VStack {
        HStack {
          TextField("Enter city", text: $city)
            .padding()
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .autocapitalization(.words)

          Button("Forecast") {
            forecast()
          }
          .buttonStyle(RoundedRectangleButtonStyle())
          .padding()
        }

        switch viewState {
        case .start: EmptyView()
        case .loading:
          Text("Loading five days forecast for \(city)...")
          ProgressView()
        case .error(let errorMessage):
          Text("Error: \(errorMessage)")
            .foregroundColor(.red)
        case .forecast(let fiveDaysForecast):
          List {
            ForEach(fiveDaysForecast.groupedList, id: \.date) { date, forecasts in
              Section(header:
                        Text(date)
                .font(.title2)
              ) {
                FiveDaysForecastDayView(forecasts: forecasts)
              }
            }
          }
        }

        Spacer()
      }
      .navigationDestination(for: FiveDaysForecast.Forecast.self ) { forecast in
        DetailForecastView(forecast: forecast)
      }
      .navigationTitle("Five Days Forecast")
    }
  }

  private func forecast() {
    Task {
      do {
        viewState = .loading
        viewState = .forecast(try await api.fiveDaysForecast(for: city))
      } catch {
        viewState = .error(error.localizedDescription)
      }
    }
  }
}

#Preview {
  FiveDaysForecastView()
    .environment(OpenWeatherMapClient(networkService: NetworkService()))
}
