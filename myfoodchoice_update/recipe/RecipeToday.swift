//
//  RecipeToday.swift
//  RecipeSearch
//
//  Created by chris on 14/12/2024.
//


// -----abondoned due to UI design updated--------

import SwiftUI

struct RecipeToday: View {
    // test code: a rercipe object of today's recommendation
    let recipeToday = Recipe(title: "Croissant Sandwich with Bacon, Egg, and Vegetables", image: Image("ImagePlaceholder"))
    
    // debug var
    @State var infoText: String = ""
    
    var body: some View {
        
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text("Today's Recommendation")
                    .font(.title2)
                    //.fontWeight(.bold)
                
                VStack(spacing: 0) {
                    recipeToday.image
                        .resizable()
                        .frame(width: 110, height: 140)
                    // test code: picture tap, do something here
                    //    .onTapGesture {
                    //        infoText = recipeToday.title
                    //    }
                    Text(recipeToday.title)
                        .foregroundStyle(.secondary)
                        .lineLimit(2)
                        //.truncationMode(.tail)
                        .frame(width: 110, height: 50)
                }
                

                //Text("\(infoText) is tapped")
            }
            .padding(.horizontal, 15)
            //.border(Color.blue)
            
            Spacer()
        }
    }
}

#Preview {
    RecipeToday()
}
