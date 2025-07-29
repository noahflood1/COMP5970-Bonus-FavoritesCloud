//
//  BookView.swift
//  Favorites
//
//  Created by Noah Flood on 7/29/25.
//

import SwiftUI

struct BookRowView: View {
    
    let book : BookModel
    @EnvironmentObject private var favorites : FavoritesViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                // was concatenating two views with "+," i think it was breaking the visual
                Text(book.bookTitle).italic()
                Text("by \(book.bookAuthor)").font(.subheadline).foregroundColor(.secondary)
            }
            Spacer()
            Button (action: {
                favorites.toggleFavoriteBook(book: book)
            }) {
                Image(systemName: book.isFavorite ? "heart.fill" : "heart")
                    .foregroundStyle(book.isFavorite ? .red : .gray)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    BookRowView(book: BookModel(id: 1, bookTitle: "Dune", bookAuthor: "Frank Herbert", isFavorite: false))
}
