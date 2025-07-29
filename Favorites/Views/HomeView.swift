//
//  HomeView.swift
//  Favorites
//
//  Created by Noah Flood on 7/19/25.
//

import SwiftUI

enum ContentCategory : String, CaseIterable {
    case cities = "Cities"
    case hobbies = "Hobbies"
    case books = "Books"
}

struct HomeView: View {
    
    @EnvironmentObject private var favorites: FavoritesViewModel
    @State private var selectedCategory: ContentCategory = .cities
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationStack {
            
            VStack {
                
                Picker("Categories", selection: $selectedCategory) {
                    ForEach(ContentCategory.allCases, id: \.self) { category in
                        Text(category.rawValue).tag(category)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                
                selectedContentView()
            }
            .navigationTitle("Browse")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $searchText, prompt: "Search \(selectedCategory.rawValue)")
        }
    }
    
    //since there are two views here (text) and Swift expects 1, we need a specialattribute
    @ViewBuilder // knows how to merge multiple views into one single view
    private func selectedContentView() -> some View {
        
        // why write "some view" above? because View is a protocol, not a concrete type
        // so we are saying "some type that follows View protocol"
        // just View is too vague
        //
        // this lets us return all different types of View, which is good for this case
        
        if selectedCategory == .cities {
            CitiesView(searchText: $searchText)
        }
        else if selectedCategory == .hobbies {
            HobbiesView(searchText: $searchText)
        }
        else if selectedCategory == .books {
            BooksView(searchText: $searchText)
        }
        
        
    }
}

#Preview {
    HomeView()
        .environmentObject(FavoritesViewModel()) // one view doesn't know anything about the hierarchy or the @EnvironmentObjects that are global, so we need this here.
}
