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
    
    // fetch the favorited items of this manager's type by id
    // (like storing data in CSV files, and parsing manually, but easier...)
    func loadFavoriteIDs(items: [T]) -> [Int] {
        return UserDefaults.standard.array(forKey: storageKey) as? [Int] ?? []
    }
    
    func initalizeFavorites(items: [T]) -> [T] {
        let savedIDs = loadFavoriteIDs(items: items)
        // The items.map { item in ... } line returns a new array where each element is the result of applying the closure to each element of the original items array.
        return items.map { item in // like a ForEach, but we create mutable copies of all the items
            // this is what is in the closure
            var updatedItem = item
            updatedItem.isFavorite = savedIDs.contains(item.id)
            return updatedItem
        }
        
    }
    
    // return an array of filtered items based on searchText
    func filteredFavorites(searchText: String, items: [T]) -> [T] {
        if searchText.isEmpty {
            return items // just send back all the items if there is no searchText
        } else {
            return items.filter {
                // this $0 stands for the current item in the array (in the above items.filter)
                // if the item meets the search criteria, it is returned as a part of a new array from items.filter
                $0.searchableText.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    // since we don't want to modify the copy of the first param
    // (we want to modify the original)
    // we use inout
    func toggleFavorite(items: inout [T], targetItem: T) { // idk why you don't need inout here on the second param
        if let index = items.firstIndex(where: { $0.id == targetItem.id }) {
            items[index].isFavorite.toggle()
        }
        
        // save a list of the id's of items that are favorited (just the ones with isFavorite == true)
        let favoriteIDs = items.filter({ $0.isFavorite }).map { $0.id }
        
        // now we need to save that favorite toggle to the user data
        saveFavoriteIDs(ids: favoriteIDs)
    }
    
    // no need to be called outside of this class; it is called after every single toggle happens.
    func saveFavoriteIDs(ids: [Int]) {
        // UserDefaults.standard is a simple way to store small pieces of info acorss app launches
        UserDefaults.standard.set(ids, forKey: storageKey) // use the instance storageKey for this manager
    }
    
    func clearFavorites(items: inout [T]) {
        // i don't know why we edit the param directly, and not just get a copy, edit it, and return it.
        // maybe because since this is the manager, it keeps handling all the data in here
        for index in items.indices {
            items[index].isFavorite = false // unfavorite all items 
        }
        // delete the saved list from UserDefaults
        UserDefaults.standard.removeObject(forKey: storageKey)
    }
    
}

