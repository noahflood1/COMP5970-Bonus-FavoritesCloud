//
//  AuthController.swift
//  FavoritesCloud
//
//  Created by Noah Flood on 7/30/25.
//

import SwiftUI

@Observable
class AuthController : ObservableObject{
    
    var authState: AuthState = .undefined
    
    func startListeningToAuthState() async {
        
    }
    
    @MainActor
    func signIn() async throws {
        
    }
    
    func signOut() throws {
        
    }
}

extension UIApplication {
    var firstKeyWindow: UIWindow? {
        return UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene}
            .filter { $0.activationState == .foregroundActive}
            .first?.windows
            .first(where: \.isKeyWindow)
    }
}

