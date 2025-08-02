//
// FavoritesViewModel.swift : Favorites
//
// Copyright © 2025 Auburn University.
// All Rights Reserved.


import Foundation
import SwiftUI

class FavoritesViewModel : ObservableObject {
    
    @Published var cities: [CityModel] = [] // published means SwiftUI will monitor it for changes
    @Published var hobbies: [HobbyModel] = []
    @Published var books: [BookModel] = []
    
    private let cityManager = CategoryManager<CityModel>(storageKey: "favoriteCities")
    private let hobbyManager = CategoryManager<HobbyModel>(storageKey: "favoriteHobbies")
    private let bookManager = CategoryManager<BookModel>(storageKey: "favoriteBooks")
    
    private let dataManager = DataManager()
    
    // INITALIZATION ----------------------------------------------------------
    
    // upon this viewModel being initalized (on app startup, coming from the App @main)
    init () {
        // populate the Favorites Model with default placeholders
        // autmoatically -> load the model with favorite toggles from UserDefaults
        cities = cityManager.initalizeFavoritesWithIDsFromUserDefaults(items: baseCities)
        hobbies = hobbyManager.initalizeFavoritesWithIDsFromUserDefaults(items: baseHobbies)
        books = bookManager.initalizeFavoritesWithIDsFromUserDefaults(items: baseBooks)
    }
    
    // the contents of this function used to be in init(), til i realized that
    // the user might not be signed in at the moment this vm is instantiated
    func onUserSignedIn() {
        // start async task to initialize Firestore doc
        // Initalize a document for the user if they are new
        fireInitializeDoc()
        // on lanch, pull from the cloud -> update the three favorite models -> save to UserDefaults
        // (does all three automatically)
        pullFavoritesFromFirestore()
        
        // the above calls populateFavoritesModel() which re-updates the local model
        // with any changes that happened to fireStore since last launch
        // by calling dataManager.loadFavoritesFromFirestore()
        // and then calls populateFavoritesModel(from: data) when that completes
        // which in turn calls xManager.saveFavoriteIDs() for each category and
        // updates UserDefaults data too for quick loading and local saving.
        //
        // as a debugging measure, this would allow you to change a value on the serverside
        // and see the change populate in the app on restart.
        
        print("Successfully initalized a doc if needed, and pulled favorites from Firestore.")
    }
    
    // ##########################################################################
    // #                      FIRESTORE SPECIFIC OPERATIONS                     #
    // ##########################################################################
    
    func fireInitializeDoc() {
        Task {
            do {
                try await dataManager.initUserDoc()
            } catch {
                print("Error initializing user document: \(error)")
            }
        }
    }
    
    // WILL AUTOMATICALLY UPDATE LOCAL MODEL!!! and user defeaults
    func pullFavoritesFromFirestore() {
        Task {
            do {
                let data = try await dataManager.loadFavoritesFromFirestore()
                await MainActor.run {
                    self.populateFavoritesModel(from: data)
                }
            } catch {
                print("Error pulling favorites user document: \(error)")
            }
        }
    }
    
    // ##########################################################################
    // #                 LOCAL MODEL CHANGES / HYRBID CHANGES                   #
    // ##########################################################################
    
    // *some contain sub-tasks that are on Main and call firestore operations
    
    // LOCAL FAVORITESMODEL-WIDE FUNCTIONS ------------------------------------
    
    func populateFavoritesModel(from data: FavoriteData) {
        cities = baseCities.map { city in
            var updated = city
            updated.isFavorite = data.favoriteCityIDs.contains(city.id)
            return updated
        }
        hobbies = baseHobbies.map { hobby in
            var updated = hobby
            updated.isFavorite = data.favoriteHobbyIDs.contains(hobby.id)
            return updated
        }
        books = baseBooks.map { book in
            var updated = book
            updated.isFavorite = data.favoriteBookIDs.contains(book.id)
            return updated
        }
        // also call the CategoryManager to save the new choices to the UserDefaults
        cityManager.saveFavoriteIDs(ids: cities.filter { $0.isFavorite }.map { $0.id })
        hobbyManager.saveFavoriteIDs(ids: hobbies.filter { $0.isFavorite }.map { $0.id })
        bookManager.saveFavoriteIDs(ids: books.filter { $0.isFavorite }.map { $0.id })
        
        print("Successfully populated the model with FavoriteData and saved it to userDefaults: \(data)")
    }
    
    // clears locally and on firestore
    func clearAllFavorites() {
        cityManager.clearFavorites(items: &cities) // direct editing
        hobbyManager.clearFavorites(items: &hobbies)
        bookManager.clearFavorites(items: &books)
        
        // Also clear on Firestore, provide all three optionals
        Task {
            try? await dataManager.saveFavoritesToFirestore(
                cityIDs: [],
                hobbyIDs: [],
                bookIDs: []
            )
        }
    }
    
    // CITY CATEGORY MANAGER CALLS --------------------------------------------
    
    func toggleFavoriteCity(city: CityModel) {
        cityManager.toggleFavorite(items: &cities, targetItem: city) // ampersand lets us edit directly
        
        // FIRESTORE UPDATE with 1 of three optional params!
        Task {
            let ids = cities.filter { $0.isFavorite }.map { $0.id }
            try? await dataManager.saveFavoritesToFirestore(cityIDs: ids)
        }
        
    }
    
    func filteredCities(searchText: String, showFavoritesOnly: Bool) -> [CityModel] {
        return cityManager.filteredFavorites(
            searchText: searchText,
            showFavoritesOnly: showFavoritesOnly,
            items: cities)
    }
    
    // HOBBY CATEGORY MANAGER CALLS -------------------------------------------
    
    func toggleFavoriteHobby(hobby: HobbyModel) {
        hobbyManager.toggleFavorite(items: &hobbies, targetItem: hobby)
        
        // FIRESTORE UPDATE with 1 of three optional params!
        Task {
            let ids = hobbies.filter { $0.isFavorite }.map { $0.id }
            try? await dataManager.saveFavoritesToFirestore(hobbyIDs: ids)
        }
    }
    
    func filteredHobbies(searchText: String, showFavoritesOnly: Bool) -> [HobbyModel] {
        return hobbyManager.filteredFavorites(
            searchText: searchText,
            showFavoritesOnly: showFavoritesOnly,
            items: hobbies)
    }
    
    // BOOK CATEGORY MANAGER CALLS --------------------------------------------
    
    func toggleFavoriteBook(book: BookModel) {
        bookManager.toggleFavorite(items: &books, targetItem: book)
        
        // FIRESTORE UPDATE with 1 of three optional params!
        Task {
            let ids = books.filter { $0.isFavorite }.map { $0.id }
            try? await dataManager.saveFavoritesToFirestore(bookIDs: ids)
        }
    }
    
    func filteredBooks(searchText: String, showFavoritesOnly: Bool) -> [BookModel] {
        return bookManager.filteredFavorites(
            searchText: searchText,
            showFavoritesOnly: showFavoritesOnly,
            items: books)
    }
     
}
