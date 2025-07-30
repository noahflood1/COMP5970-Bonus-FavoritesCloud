//
//  AuthView.swift
//  FavoritesCloud
//
//  Created by Noah Flood on 7/30/25.
//
// following a tutorial from: https://www.youtube.com/watch?v=zGp4UFlXKR8
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift
// the Firebase functionality is on the authController side
// import FirebaseCore
// import FirebaseAuth

struct AuthView: View {
    
    @Environment(AuthController.self) private var authController
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false // might not be working
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer().frame(height: geometry.size.height * 0.2) // top padding

                (
                    Text("Welcome to Favorites")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    +
                    Text("Cloud")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                )
                .multilineTextAlignment(.center)

                Spacer() // takes up the middle space

                GoogleSignInButton(scheme: .dark, style: .standard, state: .normal) {
                    signIn()
                }
                .frame(width: geometry.size.width * 0.6, height: 50)
                .clipShape(RoundedRectangle(cornerRadius: 8))

                Spacer().frame(height: geometry.size.height * 0.05) // bottom margin
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
        .preferredColorScheme(.dark)
        //.preferredColorScheme(isDarkMode ? .dark : .light)
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
