//
//  FavoriteModel.swift
//  Favorites
//
//  Created by Noah Flood on 7/28/25.
//

import Foundation

struct FavoriteData {
    let favoriteCityIDs: [Int]
    let favoriteHobbyIDs: [Int]
    let favoriteBookIDs: [Int]
}

protocol Favoritable : Identifiable {
    // these are the attributes that a Favoriteable item must have
    var id: Int { get }
    var isFavorite : Bool { get set } // this means that the protocol will include built in setters and getters for this item
    var searchableText : String { get } // only get because we don't need to change it after creation
    
}

struct CityModel : Favoritable {
    let id : Int
    let cityName: String
    let cityImage: String
    var isFavorite: Bool = false
    
    var searchableText: String{
        return cityName
    }
}

struct HobbyModel : Favoritable {
    let id : Int
    let hobbyName: String
    let hobbyIcon: String
    var isFavorite: Bool = false
    
    var searchableText: String {
        return hobbyName
    }
}

struct BookModel : Favoritable {
    let id : Int
    let bookTitle: String
    let bookAuthor: String
    var isFavorite: Bool = false
    
    var searchableText: String {
        return bookTitle + " " + bookAuthor
    }
}

