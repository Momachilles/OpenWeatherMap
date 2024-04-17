//
//  RoundedRectangleButtonStyle.swift
//  OpenWeatherMap
//
//  Created by David Alarcon on 17/4/24.
//

import SwiftUI

struct RoundedRectangleButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    HStack {
      configuration.label.foregroundColor(.white)
    }
    .padding(.init(top: 5.0, leading: 10.0, bottom: 5.0, trailing: 10.0))
    .background(Color.blue.cornerRadius(8))
    .scaleEffect(configuration.isPressed ? 0.95 : 1)
  }
}
