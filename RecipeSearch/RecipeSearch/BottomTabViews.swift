//
//  BottomTabViews.swift
//  RecipeSearch
//
//  Created by chris on 9/12/2024.
//

import SwiftUI

struct BottomTabViews: View {
    @State var text: String = ""
    
    var body: some View {
        TabView(selection: .constant(2)) {
            HomeView()
                .tabItem {
                    Image(systemName: "house").imageScale(.large)
                }
                .tag(1)
            
            SearchView(show_favorite_recipes: false)
                .tabItem {
                    Image(systemName: "magnifyingglass").imageScale(.large)
                }
                .tag(2)
            
            CameraView()
                .tabItem {
                    Image(systemName: "camera").imageScale(.large)
                }
                .tag(3)
            
            RecordView()
                .tabItem {
                    Image(systemName: "book.closed").imageScale(.large)
                }
                .tag(4)
            
            PersonalView()
                .tabItem {
                    Image(systemName: "person.crop.circle").imageScale(.large)
                }
                .tag(5)
        }
        .tint(Color("IconGreen"))
        .padding()
        //.border(Color.blue)

    }
}

#Preview {
    BottomTabViews()
}
