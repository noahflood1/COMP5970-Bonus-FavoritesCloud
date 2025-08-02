//
//  FirestoreManager.swift
//  FavoritesCloud
//
//  Created by Noah Flood on 7/31/25.
//

import Foundation
import FirebaseCore
import FirebaseFirestore

struct FirestoreReferenceManager {
    static let environment = "dev"
    static let db = Firestore.firestore()
    static let root = db.collection("\(environment)/userFavoritesCollection/users")
}
