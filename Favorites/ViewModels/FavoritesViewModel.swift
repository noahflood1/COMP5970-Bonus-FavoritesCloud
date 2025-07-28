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
    
    private let citiesManager = CategoryManager<CityModel>(storageKey: "favoriteCities")
    private let hobbiesManager = CategoryManager<HobbyModel>(storageKey: "favoriteHobbies")
    private let booksManager = CategoryManager<BookModel>(storageKey: "favoriteBooks")
    
    init () {
        // upon this vm being initalized (on app startup, coming from the App @main)
        loadFavoriteCities()
    }
    
    func filteredCities(searchText: String, items: [CityModel]) -> [CityModel] {
        return citiesManager.filteredFavorites(searchText, items)
    }
    
    func toggleFavoriteCity(city: CityModel) {
    }
    
    func saveFavoriteCities() {
        let favoriteCities = cities.filter({ $0.isFavorite }).map { $0.id } // create a list of the id's of cities that are favorited
        // UserDefaults.standard is a simple way to store small pieces of info acorss app launches
        UserDefaults.standard.set(favoriteCities, forKey: "favoriteCities")
        // favoriteCities contains just the ids of cities marked as favorite
    }
    
    // now we need to be able to fetch the favorited cities on app launch
    // i've done this before in jank python apps with Tkinter before, like in the
    // Point of Sale app that uses .csv info...
    func loadFavoriteCities() {
        // access the stored data as an array from UserDefaults/standard
        if let favoriteCityIds = UserDefaults.standard.array(forKey: "favoriteCities") as? [Int] {
            // for each index in the cities list of indixes
            for index in cities.indices {
                // let that city's favorited flag equal
                
                // this is saying:
                // - set the isFavorite attribute of this city to true or false,
                // depending on whether or not the city's id exists in the stored list of fav city ids!
                cities[index].isFavorite = favoriteCityIds.contains(cities[index].id)
            }
        }
    }
    
}


let sampleCities: [CityModel] = [

    CityModel(id : 1, cityName: "Cape Town", cityImage: "capetown", isFavorite: false),
    CityModel(id : 2, cityName: "Copenhagen", cityImage: "copenhagen", isFavorite: false),
    CityModel(id : 3, cityName: "Lisbon", cityImage: "lisbon", isFavorite: false),
    CityModel(id : 4, cityName: "Reykjavik", cityImage: "reykjavik", isFavorite: false),
    CityModel(id : 5, cityName: "Warsaw", cityImage: "warsaw", isFavorite: false),
    CityModel(id : 6, cityName: "London", cityImage: "london", isFavorite: false),
    CityModel(id : 7, cityName: "Monaco", cityImage: "monaco", isFavorite: false),
    CityModel(id : 8, cityName: "Amsterdam", cityImage: "amsterdam", isFavorite: false),
    CityModel(id : 9, cityName: "Los Angeles", cityImage: "losangeles", isFavorite: false)
]


let sampleHobbies: [HobbyModel] = [
    HobbyModel(id : 1, hobbyName: "Painting", hobbyIcon: "🎨", isFavorite: false),
    HobbyModel(id : 2, hobbyName: "Photography", hobbyIcon: "📷", isFavorite: false),
    HobbyModel(id : 3, hobbyName: "Guitar", hobbyIcon: "🎸", isFavorite: false),
    HobbyModel(id : 4, hobbyName: "Yoga", hobbyIcon: "🧘‍♀️", isFavorite: false),
    HobbyModel(id : 5, hobbyName: "Gardening", hobbyIcon: "🪴", isFavorite: false),
    HobbyModel(id : 6, hobbyName: "Cooking", hobbyIcon: "🍳", isFavorite: false),
    HobbyModel(id : 7, hobbyName: "Hiking", hobbyIcon: "🥾", isFavorite: false),
    HobbyModel(id : 8, hobbyName: "Writing", hobbyIcon: "✍️", isFavorite: false),
    HobbyModel(id : 9, hobbyName: "Dancing", hobbyIcon: "💃", isFavorite: false),
    HobbyModel(id : 10, hobbyName: "Knitting", hobbyIcon: "🧶", isFavorite: false),
    HobbyModel(id : 11, hobbyName: "Gaming", hobbyIcon: "🎮", isFavorite: false),
    HobbyModel(id : 12, hobbyName: "Calligraphy", hobbyIcon: "✒️", isFavorite: false),
    HobbyModel(id : 13, hobbyName: "Basketball", hobbyIcon: "🏀", isFavorite: false)
]

let sampleBooks: [BookModel] = [
    BookModel(id : 1, bookTitle: "To Kill a Mockingbird", bookAuthor: "Harper Lee", isFavorite: false),
    BookModel(id : 2, bookTitle: "1984", bookAuthor: "George Orwell", isFavorite: false),
    BookModel(id : 3, bookTitle: "Pride and Prejudice", bookAuthor: "Jane Austen", isFavorite: false),
    BookModel(id : 4, bookTitle: "The Great Gatsby", bookAuthor: "F. Scott Fitzgerald", isFavorite: false),
    BookModel(id : 5, bookTitle: "The Catcher in the Rye", bookAuthor: "J.D. Salinger", isFavorite: false),
    BookModel(id : 6, bookTitle: "The Hobbit", bookAuthor: "J.R.R. Tolkien", isFavorite: false),
    BookModel(id : 7, bookTitle: "Fahrenheit 451", bookAuthor: "Ray Bradbury", isFavorite: false),
    BookModel(id : 8, bookTitle: "Jane Eyre", bookAuthor: "Charlotte Brontë", isFavorite: false),
    BookModel(id : 9, bookTitle: "The Alchemist", bookAuthor: "Paulo Coelho", isFavorite: false),
    BookModel(id : 10, bookTitle: "The Book Thief", bookAuthor: "Markus Zusak", isFavorite: false),
    BookModel(id : 11, bookTitle: "Moby-Dick", bookAuthor: "Herman Melville", isFavorite: false),
    BookModel(id : 12, bookTitle: "Crime and Punishment", bookAuthor: "Fyodor Dostoevsky", isFavorite: false)
]
