//
//  HobbyRowView.swift
//  Favorites
//
//  Created by Noah Flood on 7/27/25.
//

import SwiftUI

struct HobbyRowView: View {
    
    let hobby : HobbyModel
    // this supplies us with what we need
    @EnvironmentObject private var favorites : FavoritesViewModel
    
    var body: some View {
        HStack {
            Text(hobby.hobbyIcon)
                .font(.title2)
            Text(hobby.hobbyName)
                .font(.body)
            Spacer()
            Button (action: {
                favorites.toggleFavoriteHobby(hobby: hobby)
            }) {
                Image(systemName: hobby.isFavorite ? "heart.fill" : "heart")
                    .foregroundStyle(hobby.isFavorite ? .red : .gray)
            }
        }
        .padding(.vertical, 4)
        
    }
}

#Preview {
    HobbyRowView(hobby: HobbyModel(id: 1, hobbyName: "Basketball", hobbyIcon: "🏀", isFavorite: false))
}
