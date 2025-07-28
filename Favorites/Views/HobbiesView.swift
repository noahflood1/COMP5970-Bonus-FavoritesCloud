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
        LazyVStack { // loads stuff only as needed, efficiently.
            ForEach(favorites.hobbies) { hobby in // #FIXME: actually filter by searchText
                HobbyRowView(hobby: hobby)
            }
        }
    }
}

#Preview {
    HobbyRowView(hobby: HobbyModel(id: 1, hobbyName: "Basketball", hobbyIcon: "🏀", isFavorite: false))
        .environmentObject(FavoritesViewModel())
}
