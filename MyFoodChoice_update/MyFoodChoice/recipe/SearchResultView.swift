//
//  SearchResultView.swift
//  RecipeSearch
//
//  Created by chris on 14/12/2024.
//

import SwiftUI

struct SearchResultView: View {
    @Binding var searchText: String
    
    //test code: use a bool var to test search restuls (empty and list found)
    @State var hasResult: Bool
    
    @State private var viewName: String = "SearchResultView"
    
    @Environment(\.presentationMode) var presentationMode
    
    //test code: initial a search result list, e.g., salad recipe list
    @State private var recipes: [Recipe] = [
        Recipe(title: "Grilled Meat and Egg Salad with Avocado", image: Image("ImagePlaceholder"),ingredients: ["Beef": 0, "Shrimp": 2, "Avocado": 3]),
        Recipe(title: "recipe2", image: Image("ImagePlaceholder"), ingredients: ["Beef": 2, "Shrimp": 2, "Avocado": 3, "Pork": 4, "Tomato": 2, "Eggplant": 3]),
        Recipe(title: "recipe3", image: Image("ImagePlaceholder"), ingredients: ["Beef": 0, "Shrimp": 2, "Avocado": 3]),
        Recipe(title: "recipe4", image: Image("ImagePlaceholder"), ingredients: ["Beef": 0, "Shrimp": 2, "Avocado": 3]),
        Recipe(title: "recipe5", image: Image("ImagePlaceholder"), ingredients: ["Beef": 0, "Shrimp": 2, "Avocado": 3])
    ]
    
    var body: some View {
        
        VStack(spacing: 0) {

            SearchBar(searchText: $searchText, hasResult: $hasResult, parentViewName: $viewName)
            //}

            //NavigationStack {
            
            
            if hasResult {
               
                List($recipes, id: \.title) { $recipe in

                        HStack(spacing: 10) {
                            NavigationLink(destination: RecipeDetail(recipeToDisplay: recipe)){
                                
                                recipe.image
                                    .resizable()
                                    .frame(width: 110, height: 140)
                                
                                VStack(alignment: .leading, spacing: 10) {
                                    //HStack {
                                    Text(recipe.title)
                                    //.font(.title3)
                                        .lineLimit(2)
                                    //.fontWeight(.bold)
                                        //.border(Color.red)
                                    
                                    // Spacer()
                                    
                                    // }
                                    
                                    Text(recipe.ingredients.keys.joined(separator: ","))
                                        .foregroundStyle(.secondary)
                                        .font(.system(size: 15))
                                        .lineLimit(2)
                                        //.border(Color.red)
                                }
                                
                            }
                            
                            Spacer()
                            
                            //                        VStack {
                            //                            Image(systemName: recipe.isCollected ? "suit.heart.fill" : "suit.heart")
                            //                                .imageScale(.large)
                            //                                .tint(Color("IconGreen"))
                            //                                .foregroundStyle(Color("IconGreen"))
                            //                                .onTapGesture {
                            //                                    recipe.isCollected.toggle()
                            //                                }
                            //                                //.padding(.vertical, 10)
                            //                                .border(Color.red)
                            //
                            //                            //Spacer()
                            //                        }
                            
                            //.border(Color.red)
                            
                            //                        Button(action: {
                            //                            recipe.isCollected.toggle()
                            //                        }) {
                            //                            Image(systemName: recipe.isCollected ? "suit.heart.fill" : "suit.heart")
                            //                                .imageScale(.large)
                            //                                .tint(Color("IconGreen"))
                            //                                .foregroundStyle(Color("IconGreen"))
                            //                        }
                            
                            //Spacer()
                        }
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0)) // 自定义左右边距
                        .background(Color("SearchResultBackground"))
                        .cornerRadius(15)
                        .overlay {
                            HStack {
                                Spacer()
                                
                                VStack {
                                    Image(systemName: recipe.isCollected ? "suit.heart.fill" : "suit.heart")
                                        .imageScale(.large)
                                        .tint(Color("IconGreen"))
                                        .foregroundStyle(Color("IconGreen"))
                                        .onTapGesture {
                                            recipe.isCollected.toggle()
                                            
                                            // identify if the current recipe is already added to user's favourate
                                            
                                            // to do: add to user's favourate recipes list ..............
                                            
                                        }
                                        .padding(5)
                                    
                                    Spacer()
                                }
                                .background(Color("SearchResultBackground"))

                        }
                        //.border(Color.red)
                    }
                }
                //.border(Color.red)
                .scrollContentBackground(.hidden)
                //.onTapGesture {
                    // go to a specific recipe
                //}
            } else {
                Image("NoResult")
                //.border(Color.red)
                
                Spacer()
            }
            
            //}
            //.border(Color.red)
            //.searchable(text: $searchText, prompt: "Search recipes...")
            
        }
        .safeAreaInset(edge: .top, spacing: 0) { // 自定义顶部安全区域
            Color.clear.frame(height: 0) // 模拟一个 0 点的安全区域
        }
        .navigationBarTitleDisplayMode(.inline) //移除navigationTitle及其占用的空间
        .navigationBarBackButtonHidden(true) // 隐藏默认返回按钮
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss() // 手动返回上一视图
                }) {
                    HStack() {
                        Image(systemName: "chevron.left") // 自定义返回图标
                            .toolbar {
                                ToolbarItem(placement: .principal) {
                                    Text("Recipe Searching")
                                        .font(.title) // 可以调整样式
                                        .bold()
                                }
                            }
                    }
                    //.border(Color.red)
                }
                .tint(Color.black)
                
            }
        }
    }
}

#Preview {
    @Previewable @State var searchText: String = ""
    @Previewable @State var hasResult: Bool = true
    
    SearchResultView(searchText: $searchText, hasResult: hasResult)
}
