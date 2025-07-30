//
//  SettingsView.swift
//  Favorites
//
//  Created by Noah Flood on 7/19/25.
//

import SwiftUI

struct SettingsView: View {
    
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    @EnvironmentObject private var favoritesViewModel: FavoritesViewModel
    @State private var showResetAlert: Bool = false
    @Environment(AuthController.self) private var authController
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header : Text("Appearance")) {
                    Toggle(isOn: $isDarkMode) {
                        Label("Dark Mode", systemImage: "moon.fill")
                    }
                }
                Section {
                    Button(role: .destructive) {
                        showResetAlert = true
                    } label: {
                        Label("Clear All Favorites", systemImage: "trash")
                    }
                }
                .alert("Are you sure you want to clear all favorites?", isPresented: $showResetAlert) {
                    Button("Clear", role: .destructive) {
                        favoritesViewModel.clearAllFavorites()
                    }
                    Button("Cancel", role: .cancel) { }
                } message: {
                    Text("All favorites will be deleted.")
                }
                Section {
                    Button("Sign Out") {
                        signOut()
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
    
    // access to signing out in this view, which will update the authentication status
    func signOut() {
        do {
            try authController.signOut()
        } catch {
            print(error.localizedDescription)
        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(FavoritesViewModel())
}
