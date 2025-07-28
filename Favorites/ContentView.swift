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
            Tab("Favorites", systemImage: "square.grid.2x2", value: .home) {
                FavoritesView()
            }
            Tab("Settings", systemImage: "square.grid.2x2", value: .home) {
                SettingsView()
            }
            
        }
    }
}

#Preview {
    ContentView()
}
