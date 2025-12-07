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
            Text("Breaking Bad View")
                .toolbarBackgroundVisibility(.visible, for: .tabBar)
                .tabItem {
                    Label("Breaking Bad", systemImage: "tortoise")
                }
            
            // Second Tab: Better Call Saul View
            Text("Better Call Saul View")
                .toolbarBackgroundVisibility(.visible, for: .tabBar)
                .tabItem {
                    Label("Better Call Saul", systemImage: "briefcase")
                }
        } 
    }
}

#Preview {
    ContentView()
}
