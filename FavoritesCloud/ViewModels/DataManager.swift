//
//  DataManager.swift
//  FavoritesCloud
//
//  Created by Noah Flood on 7/31/25.
//
// Meant for thin Firestore CRUD abstraction.
//

import Foundation
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore

class DataManager : ObservableObject {
    
    let db = Firestore.firestore()
    
    static var uid : String = ""
    
    func getUID() async -> String {
        if !DataManager.uid.isEmpty {
            print("Successfully returned UserID from cache: \(DataManager.uid)")
            return DataManager.uid // just return cached result
        }
        guard let uid = Auth.auth().currentUser?.uid else {
            print("ERROR: Firebase user is not signed in yet.")
            return "" // this means the app will work even if there is no user id... and it will cause problems down the line, so be careful
        }
        DataManager.uid = uid
        print("Successfully pulled UserID from Firebase: \(uid)")
        return uid
    }
    
    func initUserDoc() async throws {
        let uid = await getUID()
        let docRef = FirestoreReferenceManager.root.document(uid)
        let doc = try await docRef.getDocument()

        if !doc.exists {
            try await docRef.setData([
                "favoriteCities": [],
                "favoriteHobbies": [],
                "favoriteBooks": []
            ])
            print("User doc initialized for user \(uid)")
        } else {
            print("User doc already exists.")
        }
    }
    
    func loadFavoritesFromFirestore() async throws -> FavoriteData {
        let uid = await getUID()
        let doc = try await FirestoreReferenceManager.root.document(uid).getDocument()
        let data = doc.data() ?? [:]
        
        let cityIDs = data["favoriteCities"] as? [Int] ?? []
        let hobbyIDs = data["favoriteHobbies"] as? [Int] ?? []
        let bookIDs = data["favoriteBooks"] as? [Int] ?? []
        
        var favs = FavoriteData (
            favoriteCityIDs: cityIDs,
            favoriteHobbyIDs: hobbyIDs,
            favoriteBookIDs: bookIDs
        )
        
        print("Successfully loaded favorites from Firestore: \(favs)")
        
        return favs
    }
    
    func saveFavoritesToFirestore(
        // these are optional since I might only have to update certain Ids at a time.
        cityIDs: [Int]? = nil,
        hobbyIDs: [Int]? = nil,
        bookIDs: [Int]? = nil
    ) async throws {
        let uid = await getUID()
        var updateData: [String: Any] = [:] //means create an empty dictionary that maps String keys to values of any type.

        if let cityIDs = cityIDs {
            updateData["favoriteCities"] = cityIDs
            print("DEBUG: Updated favoriteCities with IDs: \(cityIDs)")
        }
        if let hobbyIDs = hobbyIDs {
            updateData["favoriteHobbies"] = hobbyIDs
            print("DEBUG: Updated favoriteCities with IDs: \(hobbyIDs)")
        }
        if let bookIDs = bookIDs {
            updateData["favoriteBooks"] = bookIDs
            print("DEBUG: Updated favoriteCities with IDs: \(bookIDs)")
        }

        try await FirestoreReferenceManager.root
            .document(uid)
            .setData(updateData, merge: true) // merge avoids overwriting
    }
    
}



