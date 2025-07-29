//
//  BooksView.swift
//  Favorites
//
//  Created by Noah Flood on 7/29/25.
//

import SwiftUI

struct BooksView: View {
    
    @EnvironmentObject private var favorites : FavoritesViewModel
    @Binding var searchText: String
    
    // FOR FAVORITES TAB
    // will be passed when the view is instantiated
    // so that we can reuse this view for when we need to filter by favorites AND searchText, or just searchText
    var showFavoritesOnly : Bool
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(favorites.filteredBooks(
                    searchText: searchText,
                    showFavoritesOnly: showFavoritesOnly)) { book in
                    BookRowView(book: book)
                }
            }
            .padding()
        }
    }
}

#Preview {
    BooksView(searchText: .constant(""), showFavoritesOnly: false)
        .environmentObject(FavoritesViewModel())
}
