//
//  AuthView.swift
//  FavoritesCloud
//
//  Created by Noah Flood on 7/30/25.
//
// following a tutorial from: https://www.youtube.com/watch?v=zGp4UFlXKR8
//

import SwiftUI
import FirebaseCore
import GoogleSignIn
import GoogleSignInSwift
import FirebaseAuth

struct AuthView: View {
    
    @Environment(AuthController.self) private var authController
    
    var body: some View {
        VStack() {
            Spacer()
            
            Text("Welcome to") + Text("FavoritesCloud") // might not be the best
                .font(.largeTitle)
                .fontWeight(.bold)
            
            GoogleSignInButton(scheme: .dark, style: .standard, state: .normal) {
                signIn()
            }
            // just ralized why some params are dot notation like this. i think its because it's inherently from self
            
            
            Spacer()
        }
        .padding()
    }
    
    @MainActor
    func signIn() {
        Task {
            do {
                try await authController.signIn()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

#Preview {
    AuthView()
}
