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
    VStack {
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

      switch viewState {
      case .start: EmptyView()
      case .loading:
        Text("Loading five days forecast for \(city)...")
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
              ForEach(forecasts, id: \.dt) { forecast in
                HStack(alignment: .center) {
                  Text(forecast.dt.timeString)
                  Spacer()
                  Text(forecast.weather[0].main)
                  Spacer()
                  Text("\(Int(forecast.main.temp)) ºC")
                }
              }
            }
          }
        }
      }

      Spacer()
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

extension TimeInterval {
  var forecastDateFormatted: String {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .short

    return formatter.string(from: Date(timeIntervalSince1970: self))
  }

  var dateString: String {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .none

    return formatter.string(from: Date(timeIntervalSince1970: self))
  }

  var timeString: String {
    let formatter = DateFormatter()
    formatter.dateStyle = .none
    formatter.timeStyle = .short

    return formatter.string(from: Date(timeIntervalSince1970: self))
  }
}
