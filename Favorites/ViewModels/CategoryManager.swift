//
//  CategoryManager.swift
//  Favorites
//
//  Created by Noah Flood on 7/28/25.
//

/*
 Generic class
 File that will handle eveyrthing related to favorites for any Favoritable type:
 - Toggling favs
 - Saving and loading favorites
 - Filtering favorites based on search text
 - Clearing all favs
 Makes it easier to add new favorite categories in the future withour reusing code.
 */

import Foundation

// we will use one of these for each Favoritable subtype (or more accurately, type that implements it)
class CategoryManager<T: Favoritable> { // any type, T, that conforms to Favoritable
    
    // this is so that each CategoryManager knows where to write its data
    // in the UserDefaults
    private let storageKey: String
    
    init (storageKey: String) {
        self.storageKey = storageKey
    }
    
    // since we don't want to modify the copy of the first param
    // (we want to modify the original)
    // we use inout
    func toggleFavorite(items: inout [T], targetItem: T) { // idk why you don't need inout here on the second param
        if let index = items.firstIndex(where: { $0.id == targetItem.id }) {
            items[index].isFavorite.toggle()
        }
        
        // now we need to save that favorite toggle to the user data
        saveFavorites()
    }
    
    func saveFavorites() {
        
    }
    
    func loadFavorites() {
        
    }
    
    func filteredFavorites(searchText: String, items: inout [T]) -> inout [T] {
        if searchText.isEmpty {
            // return all items
            return items
        } else {
            return items.filter {
                // this $0 stands for the current items in the array (in the above items.filter)
                // if something meets the criteria, it is returned as a part of a new array from items.filter
                $0.searchableText().lowercased().contains(searchText.lowercased()) // just lowercase the cityName and searchtext so its case insensitive
            }
        }
}

