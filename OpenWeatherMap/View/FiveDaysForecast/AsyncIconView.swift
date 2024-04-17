//
//  AsyncIconView.swift
//  OpenWeatherMap
//
//  Created by David Alarcon on 17/4/24.
//

import SwiftUI

struct AsyncIconView: View {
  @Environment(OpenWeatherMapClient.self) private var api

  enum ViewState {
    case loading
    case error(_ errorMessage: String)
    case iconData(_ data: Data)
  }

  @State private var viewState: ViewState = .loading
  @State private var iconData: Data = Data()

  let iconName: String

  var body: some View {
    Group {
      switch viewState {
      case .loading: ProgressView()
      case .error(let errorMessage):
        Text(errorMessage)
          .foregroundColor(.red)
      case .iconData(let data):
        if let iconImage = UIImage(data: data) {
          Image(uiImage: iconImage)
            .resizable()
            .scaledToFit()
        }
      }
    }
    .task {
      await loadData(from: iconName)
    }
  }

  private func loadData(from iconName: String) async {
    do { viewState = .iconData(try await api.data(from: iconName)) }
    catch { viewState = .error(error.localizedDescription) }
  }
}

#Preview("Rain Night") {
  AsyncIconView(iconName: "10n")
    .environment(OpenWeatherMapClient(networkService: NetworkService()))
}

#Preview("Rain Day") {
  AsyncIconView(iconName: "10d")
    .environment(OpenWeatherMapClient(networkService: NetworkService()))
}
