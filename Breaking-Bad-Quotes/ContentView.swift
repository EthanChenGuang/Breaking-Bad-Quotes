//
//  ContentView.swift
//  Breaking-Bad-Quotes
//
//  Created by Guang on 2025/12/2.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    TabView {
      // First Tab: Breaking Bad View
      FetchView(show: "Breaking Bad")
        .toolbarBackgroundVisibility(.visible, for: .tabBar)
        .tabItem {
          Label("Breaking Bad", systemImage: "tortoise")
        }

      // Second Tab: Better Call Saul View
      FetchView(show: "Better Call Saul")
        .toolbarBackgroundVisibility(.visible, for: .tabBar)
        .tabItem {
          Label("Better Call Saul", systemImage: "briefcase")
        }

      // Third Tab: El Camino View
      FetchView(show: "El Camino")
        .toolbarBackgroundVisibility(.visible, for: .tabBar)
        .tabItem {
          Label("El Camino", systemImage: "car")
        }
    }
  }
}

#Preview {
  ContentView()
}
