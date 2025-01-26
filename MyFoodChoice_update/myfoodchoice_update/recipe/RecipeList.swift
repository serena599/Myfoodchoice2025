//
//  RecipeList.swift
//  RecipeSearch
//
//  Created by chris on 13/12/2024.
//

import SwiftUI

struct RecipeList: View {
    @State private var infoText = ""
    
    //@Binding var selectedRecipe: Recipe
    @State var recipeToDisplay: Recipe?
    
    let recipes: [Recipe] = [
        Recipe(title: "Grilled Meat and Egg Salad with Avocado", image: Image("ImagePlaceholder"), ingredients: ["Beef": 2, "Shrimp": 2, "Avocado": 3, "Pork": 4, "Tomato": 2, "Eggplant": 3]),
        Recipe(title: "recipe2", image: Image("ImagePlaceholder")),
        Recipe(title: "recipe3", image: Image("ImagePlaceholder")),
        Recipe(title: "recipe4", image: Image("ImagePlaceholder")),
        Recipe(title: "recipe5hvikdhkdhgksdhdkdjgh", image: Image("ImagePlaceholder")),
        Recipe(title: "recipe6", image: Image("ImagePlaceholder")),
        Recipe(title: "recipe7", image: Image("ImagePlaceholder")),
        Recipe(title: "recipe8", image: Image("ImagePlaceholder")),
        Recipe(title: "recipe9", image: Image("ImagePlaceholder")),
        Recipe(title: "recipe10", image: Image("ImagePlaceholder"))
    ]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        /*
        // test code: picture tapped info
        //Text("\(infoText) is tapped")
        ScrollView(.horizontal, showsIndicators: true) {
            HStack(spacing: 15) {
                ForEach(recipes, id: \.title) { recipe in
                    
                    VStack(spacing: 0) {
                        recipe.image
                            .resizable()
                            .frame(width: 110, height: 140)
                        
                            //.clipShape(Circle())
                            .onTapGesture {
                                infoText = recipe.title
                            }
                        
                            Text(recipe.title)
                                .foregroundStyle(.secondary)
                                .lineLimit(2)
                                //.truncationMode(.tail)
                                .frame(width: 110, height: 50)

                    }
                    //.border(Color.green)
                }
            }
        }
        .padding(15)
        //.border(Color.red)
        */
        
        Text("\(infoText)")
        
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(recipes, id: \.title) { recipe in
                    
                    NavigationLink(destination: RecipeDetail(recipeToDisplay: recipe)){
                        
                        VStack {
                            recipe.image
                                .resizable()
                                .frame(width: 110, height: 140)
//                                .onTapGesture {
//                                // for tap gesture test
//                                infoText = recipe.title
//                                
//                                // send tap result to parent view
//                                selectedRecipe = recipe
//                            }
                            
                            Text(recipe.title)
                                .font(.system(size: 14))
                                .foregroundStyle(.secondary)
                                .lineLimit(3)
                                .frame(maxHeight: 60)
                                .tint(Color.black)
                        }
//                        Text(recipe.title)
//                            .font(.system(size: 14))
//                            .foregroundStyle(.secondary)
//                            .lineLimit(3)
//                            .frame(maxHeight: 60)
                    }
                    //.padding(5)
                    //.border(Color.red)
                }
            }
            .padding()
        }
    }
}

#Preview {
    //RecipeList()
}
