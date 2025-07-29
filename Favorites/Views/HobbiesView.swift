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
    
    var body: some View {
        ScrollView {
            LazyVStack { // loads stuff only as needed, efficiently.
                ForEach(favorites.filteredHobbies(searchText: searchText)) { hobby in
                    HobbyRowView(hobby: hobby)
                }
            }
            .padding()
        }
    }

}

#Preview {
    HobbiesView(searchText: .constant(""))
        .environmentObject(FavoritesViewModel())
}
