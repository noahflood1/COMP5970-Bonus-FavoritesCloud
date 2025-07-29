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
                                
                            CitiesView(searchText: $searchText, showFavoritesOnly: true)
                        }
                        
                        Section(header: Text("Favorite Hobbies")
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top, 10)) {
                                
                            HobbiesView(searchText: $searchText, showFavoritesOnly: true)
                        }
                        
                        Section(header: Text("Favorite Books")
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top, 10)) {
                                
                            BooksView(searchText: $searchText, showFavoritesOnly: true)
                        }
                    }
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
