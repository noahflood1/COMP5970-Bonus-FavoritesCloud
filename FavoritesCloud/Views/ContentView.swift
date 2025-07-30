//
// ContentView.swift : Favorites
//
// Copyright © 2025 Auburn University.
// All Rights Reserved.


import SwiftUI

enum TabSelections {
    case home
    case favorites
    case settings
}

struct ContentView: View {
    
    @State private var selection: TabSelections = .home
    
    var body: some View {
        TabView(selection: $selection) {
            Tab("Home", systemImage: "square.grid.2x2", value: .home) {
                HomeView()
            }
            Tab("Favorites", systemImage: "heart.fill", value: .favorites) {
                FavoritesView()
            }
            Tab("Settings", systemImage: "gear", value: .settings) {
                SettingsView()
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(FavoritesViewModel())
}
