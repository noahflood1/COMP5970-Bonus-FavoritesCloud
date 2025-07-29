//
//  FavoritesView.swift
//  Favorites
//
//  Created by Noah Flood on 7/19/25.
//

import SwiftUI

struct FavoritesView: View {
    
    @EnvironmentObject private var favorites: FavoritesViewModel
    @State private var searchText: String = "" // we still need this because we want to also be able to search our favorites
    
    var body: some View {
        NavigationStack {
                ScrollView {
                    VStack {
                        Section(header: Text("Favorite Cities")
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top, 10)) {
                                
                            ForEach(favorites.favoriteCities(searchText: searchText)) { city in
                                CityCardView(city: city)
                            }
                        }
                        
                        Section(header: Text("Favorite Hobbies")
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top, 10)) {
                                
                            ForEach(favorites.favoriteHobbies(searchText: searchText)) { hobby in
                                HobbyRowView(hobby: hobby)
                            }
                        }
                        
                        Section(header: Text("Favorite Books")
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top, 10)) {
                                
                            ForEach(favorites.favoriteBooks(searchText: searchText)) { book in
                                BookRowView(book: book)
                            }
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Favorites")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $searchText, prompt: "Search Favorites") // #FIXME: displays properly?
    }
}

#Preview {
    FavoritesView()
        .environmentObject(FavoritesViewModel())
}
