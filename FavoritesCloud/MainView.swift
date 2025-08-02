//
//  MainView.swift
//  FavoritesCloud
//
//  Created by Noah Flood on 7/30/25.
//

import SwiftUI

struct MainView: View {
    
    @Environment(AuthController.self) private var authController
    
    // this accesses an already existant variable in order to read it
    @EnvironmentObject private var favoritesViewModel: FavoritesViewModel
    // flag to track whether or not the ViewModel has initalized Firestore db for new users
    // and/or whether or not the favs data from firestore has been pulled
    @State private var hasInitializedFavorites = false
    
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    
    var body: some View {
        Group {
            switch authController.authState {
            case .undefined:
                ProgressView()
                
            case .authenticated:
                ContentView()
                    .onAppear {
                        print("User is authenticated! ContentView shown.")
                        if !hasInitializedFavorites {
                            print("The user has not initialized the app yet.")
                            favoritesViewModel.onUserSignedIn() // initalize firestore now that the user is authenticated
                            hasInitializedFavorites = true
                        }
                    }
                
            case .notAuthenticated:
                AuthView()
            }
        }
        .task {
            await authController.startListeningToAuthState()
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}

#Preview {
    MainView()
        .environmentObject(AuthController())
}
