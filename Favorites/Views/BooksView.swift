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
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(favorites.filteredBooks(searchText: searchText)) { book in
                    BookRowView(book: book)
                }
            }
            .padding()
        }
    }
}

#Preview {
    BooksView(searchText: .constant(""))
        .environmentObject(FavoritesViewModel())
}
