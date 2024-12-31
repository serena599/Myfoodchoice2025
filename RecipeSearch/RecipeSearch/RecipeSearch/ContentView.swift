//
//  ContentView.swift
//  RecipeSearch
//
//  Created by chris on 9/12/2024.
//

// ------for testing purpose, abondoned----------

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Tab("" , systemImage: "house") {
                Text("PlaceHolder for Home View")
            }
            .badge("1")
        }
    }
}

#Preview {
    ContentView()
}
