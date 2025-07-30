//
//  MainView.swift
//  FavoritesCloud
//
//  Created by Noah Flood on 7/30/25.
//

import SwiftUI

struct MainView: View {
    
    @Environment(AuthController.self) private var authController
    
    var body: some View {
        Group {
            switch authController.authState {
            case .undefined:
                ProgressView()
            case .authenticated:
                ContentView()
            case .notAuthenticated:
                AuthView()
            }
        }
        .task {
            await authController.startListeningToAuthState()
        }
    }
}

#Preview {
    MainView()
        .environmentObject(FavoritesViewModel())
        .environmentObject(AuthController())
}
