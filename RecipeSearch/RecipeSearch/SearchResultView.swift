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
    //@State var hasResult: Bool
    
    @State private var viewName: String = "SearchResultView"
    
    @Environment(\.presentationMode) var presentationMode
    
    //test code: initial a search result list, e.g., salad recipe list
    /*
    @State private var recipes: [Recipe] = [
        Recipe(recipe_ID: 1, recipe_name: "Grilled Meat and Egg Salad with Avocado", image_URL: "",traffic_lights:
                ["Saturates": "green", "Salt": "green", "Surgar": "yellow", "Fat": "yellow"]
              ),
        Recipe(recipe_ID: 2, recipe_name: "recipe2", image_URL: "", traffic_lights: ["Saturates": "green", "Salt": "green", "Surgar": "yellow", "Fat": "yellow"]),
        Recipe(recipe_ID: 3, recipe_name: "recipe3", image_URL: "", traffic_lights: ["Saturates": "green", "Salt": "green", "Surgar": "yellow", "Fat": "yellow"]),
        Recipe(recipe_ID: 4, recipe_name: "recipe4", image_URL: "", traffic_lights: ["Saturates": "green", "Salt": "green", "Surgar": "yellow", "Fat": "yellow"]),
        Recipe(recipe_ID: 5, recipe_name: "recipe5", image_URL: "", traffic_lights: ["Saturates": "green", "Salt": "green", "Surgar": "yellow", "Fat": "yellow"])
    ]
     */
    
    
    //观察外部的RecipeFetcher，即来自SearchBar的searchFetcher获取的数据
    @ObservedObject var fetcher: RecipeFetcher
    
    var body: some View {
        
        VStack(spacing: 0) {

            SearchBar(searchText: $searchText, parentViewName: $viewName, fetcher: fetcher)
            //}

            //NavigationStack {

            if !fetcher.recipes.isEmpty {
               
                List($fetcher.recipes, id: \.recipe_name) { $recipe in

                        HStack(spacing: 10) {
                            NavigationLink(destination: RecipeDetail(recipeToDisplay: recipe)){
                                
                                AsyncImage(url: URL(string: recipe.image_URL)) { phase in
                                            if let image = phase.image {
                                                image.resizable().scaledToFit()
                                            } else if phase.error != nil {
                                                Image("ImagePlaceholder").resizable()
                                            } else {
                                                ProgressView() // 显示加载指示器
                                            }
                                        }
                                        .frame(width: 110, height: 140)
                                
                                VStack(alignment: .leading, spacing: 10) {
                                    //HStack {
                                    Text(recipe.recipe_name)
                                    //.font(.title3)
                                        .lineLimit(2)
                                    //.fontWeight(.bold)
                                        //.border(Color.red)
                                    
                                    // Spacer()
                                    
                                    // }

                                    
                                    Text(recipe.instructions)
                                        .foregroundStyle(.secondary)
                                        .font(.system(size: 15))
                                        .lineLimit(2)
                                    
                                }
                                
                            }
                            
                            Spacer()

                        }
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0)) // 自定义左右边距
                        .background(Color("SearchResultBackground"))
                        .cornerRadius(15)
                        .overlay {
                            HStack {
                                Spacer()
                                
                                VStack {
                                    Image(systemName: recipe.is_recommend ? "suit.heart.fill" : "suit.heart")
                                        .imageScale(.large)
                                        .tint(Color("IconGreen"))
                                        .foregroundStyle(Color("IconGreen"))
                                        .onTapGesture {
                                            recipe.is_recommend.toggle()
                                            
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
        .onAppear {
            fetcher.searchRecipes(searchQuery: searchText) // 避免没有数据
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
    @Previewable @State var fetcher: RecipeFetcher! = nil
    
    SearchResultView(searchText: $searchText, fetcher: fetcher)
}
