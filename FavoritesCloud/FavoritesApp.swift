//
// FavoritesApp.swift : Favorites
//
// Copyright © 2025 Auburn University.
// All Rights Reserved.


import SwiftUI

@main
struct FavoritesApp: App {
    
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @StateObject private var favoritesViewModel = FavoritesViewModel()
    
    @StateObject private var authController = AuthController()
    
    // don't need this, because FavoritesViewController is the sole owner
    // of cities, hobbies, and books, and is the only handler of the DataManager() instance.
    //@StateObject private var dataManager = DataManager()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(favoritesViewModel)
                .environmentObject(authController)
                //.environmentObject(dataManager)
        }
    }
}
