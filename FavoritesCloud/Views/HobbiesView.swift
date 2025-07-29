//
//  HobbiesView.swift
//  Favorites
//
//  Created by Noah Flood on 7/28/25.
//

import SwiftUI

struct HobbiesView: View {
    
    @EnvironmentObject var favorites: FavoritesViewModel
    @Binding var searchText: String // binding means it changes
    
    // FOR FAVORITES TAB
    // will be passed when the view is instantiated
    // so that we can reuse this view for when we need to filter by favorites AND searchText, or just searchText
    var showFavoritesOnly : Bool
    
    var body: some View {
        ScrollView {
            LazyVStack { // loads stuff only as needed, efficiently.
                ForEach(favorites.filteredHobbies(
                    searchText: searchText,
                    showFavoritesOnly: showFavoritesOnly)) { hobby in
                    HobbyRowView(hobby: hobby)
                }
            }
            .padding()
        }
    }

}

#Preview {
    HobbiesView(searchText: .constant(""), showFavoritesOnly: false)
        .environmentObject(FavoritesViewModel())
}
