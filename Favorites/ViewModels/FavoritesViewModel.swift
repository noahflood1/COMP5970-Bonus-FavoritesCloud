//
// FavoritesViewModel.swift : Favorites
//
// Copyright © 2025 Auburn University.
// All Rights Reserved.


import Foundation
import SwiftUI

class FavoritesViewModel : ObservableObject {
    
    @Published var cities: [CityModel] = sampleCities // published means SwiftUI will monitor it for changes
    @Published var hobbies: [HobbyModel] = sampleHobbies
    @Published var books: [BookModel] = sampleBooks
    
    private let cityManager = CategoryManager<CityModel>(storageKey: "favoriteCities")
    private let hobbyManager = CategoryManager<HobbyModel>(storageKey: "favoriteHobbies")
    private let bookManager = CategoryManager<BookModel>(storageKey: "favoriteBooks")
    
    init () {
        // upon this vm being initalized (on app startup, coming from the App @main)
        cities = cityManager.initalizeFavorites(items: sampleCities)
        hobbies = hobbyManager.initalizeFavorites(items: sampleHobbies)
        books = bookManager.initalizeFavorites(items: sampleBooks)
    }
    
    func clearAllFavorites() {
        cityManager.clearFavorites(items: &cities) // direct editing
        hobbyManager.clearFavorites(items: &hobbies)
        bookManager.clearFavorites(items: &books)
    }
    
    // CITY CATEGORY MANAGER CALLS -------------------------------------------------
    
    func toggleFavoriteCity(city: CityModel) {
        cityManager.toggleFavorite(items: &cities, targetItem: city) // ampersand lets us edit directly
    }
    
    func filteredCities(searchText: String) -> [CityModel] {
        return cityManager.filteredFavorites(searchText: searchText, items: cities)
    }
    
    // HOBBY CATEGORY MANAGER CALLS -------------------------------------------------
    
    func toggleFavoriteHobby(hobby: HobbyModel) {
        hobbyManager.toggleFavorite(items: &hobbies, targetItem: hobby)
    }
    
    func filteredHobbies(searchText: String) -> [HobbyModel] {
        return hobbyManager.filteredFavorites(searchText: searchText, items: hobbies)
    }
    
    // BOOK CATEGORY MANAGER CALLS -------------------------------------------------
    
    func toggleFavoriteBook(book: BookModel) {
        bookManager.toggleFavorite(items: &books, targetItem: book)
    }
    
    func filteredBooks(searchText: String) -> [BookModel] {
        return bookManager.filteredFavorites(searchText: searchText, items: books)
    }
     
}
