//
//  SearchView.swift
//  RecipeSearch
//
//  Created by chris on 9/12/2024.
//

import SwiftUI

struct SearchView: View {
    //@State var selectedRecipe: Recipe = Recipe(title: "", image: Image("ImagePlaceholder"))
    
    @State private var viewName: String = "SearchView"
    
    @State private var receipeList: [String] = []
    @State private var searchText = ""
    @State private var searhIsActive: Bool = false
    @State private var tabSelection: Int = 1
    @State private var hasResult: Bool = false
    
    //test code, initial a recipe list contains 4 rercipes
    
    var body: some View {
        
        // get recommendation list
        
        //ScrollView {
  
        NavigationStack() {
                
                VStack {
                    // search bar
                    SearchBar(searchText: $searchText, hasResult: $hasResult, parentViewName: $viewName)
                    
                    // debuug for navigation
                    //Text("\(tabSelection) is selected")
                    
                    // meal navigation
                    HStack(spacing: 10) {
                        // meal lists navigation tabs (4)
                        
                        //Popular
                        Button {
                            if tabSelection != 1 {
                                tabSelection = 1
                            }
                            
                            // to do: switch to recommendation list of popular recipes...
                            
                        } label: {
                            if tabSelection == 1 {
                                Text("Recommendation").font(.headline)
                                    .frame(maxWidth: 170, maxHeight: 40)
                                    .foregroundColor(.white)
                                    .background(
                                        Capsule()
                                            .stroke(Color("IconGreen"), lineWidth: 0.8)
                                            .background(Color("IconGreen"))
                                        //.clipped()
                                    )
                                    .clipShape(Capsule())
                            } else {
                                Text("Recommendation").font(.headline)
                                    .frame(maxWidth: 170, maxHeight: 40)
                                    .foregroundColor(.black)
                                
                            }
                        }
                        
                        
                        //Breakfast
                        Button {
                            if tabSelection != 2 {
                                tabSelection = 2
                            }
                            
                            // to do: switch to recommendation list of breakfast recipes...
                            
                        } label: {
                            if tabSelection == 2 {
                                Text("My favorite").font(.headline)
                                    .frame(maxWidth: 170, maxHeight: 40)
                                    .foregroundColor(.white)
                                    .background(
                                        Capsule()
                                            .stroke(Color("IconGreen"), lineWidth: 0.8)
                                            .background(Color("IconGreen"))
                                    )
                                    .clipShape(Capsule())
                            } else {
                                Text("My favorite").font(.headline)
                                    .frame(maxWidth: 170, maxHeight: 40)
                                    .foregroundColor(.black)
                            }
                            //.cornerRadius(100)
                        }
                        
                        /*
                         //Lunch
                         Button {
                         if tabSelection != 3 {
                         tabSelection = 3
                         }
                         
                         // to do: switch to recommendation list of lunch recipes...
                         
                         } label: {
                         if tabSelection == 3 {
                         Text("Lunch").fontWeight(.bold)
                         .frame(width: 90, height: 40)
                         .foregroundColor(.white)
                         .background(
                         Capsule()
                         .stroke(Color.green, lineWidth: 0.8)
                         .background(Color.green)
                         )
                         .clipShape(Capsule())
                         } else {
                         Text("Lunch").fontWeight(.bold)
                         .frame(width: 90, height: 40)
                         .foregroundColor(.gray)
                         }
                         }
                         
                         //Dinner
                         Button {
                         if tabSelection != 4 {
                         tabSelection = 4
                         }
                         
                         // to do: switch to recommendation list of dinner recipes...
                         
                         } label: {
                         if tabSelection == 4 {
                         Text("Dinner").fontWeight(.bold)
                         .frame(width: 90, height: 40)
                         .foregroundColor(.white)
                         .background(
                         Capsule()
                         .stroke(Color.green, lineWidth: 0.8)
                         .background(Color.green)
                         )
                         .clipShape(Capsule())
                         } else {
                         Text("Dinner").fontWeight(.bold)
                         .frame(width: 90, height: 40)
                         .foregroundColor(.gray)
                         }
                         }
                         */
                        
                    }
                    .tint(Color.gray)
                    .frame(height: 40)
                    //.padding(.top, 10)
                    //.border(Color.red)
                    //ScrollView {
                    
                    RecipeList()
                    
                    //RecipeToday()
                    
                    //}
                    //.border(Color.black)
                    
                    //GuideLines()
                    
                    //Spacer()
            
                    
                    //test code: test recipe tap, return the title string
                    //Text("\(selectedRecipe.title)")
                }
        }
    }
}

#Preview {
    SearchView()
}
