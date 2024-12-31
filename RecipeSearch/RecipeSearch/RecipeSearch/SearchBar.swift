//
//  SearchBar.swift
//  RecipeSearch
//
//  Created by chris on 11/12/2024.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    @State private var isEditing = false
    
    //test var: to toggle if search has result
    @Binding var hasResult: Bool
    
    //@State private var isResultFound = false
    //@State private var isTapped = false
    
    @Binding var parentViewName: String
    
    var body: some View {
        
        
            
        
        HStack {
            TextField("Search recipes...", text: $searchText)
                .padding(15)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(30)
                .overlay {
                    HStack {
                        // magnifyinglass icon
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                        
                        // "x" clear icon displayed when editing
                        if !searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                            Button(action: {
                                self.searchText = ""
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundStyle(.gray)
                                    .padding(.trailing, 8)
                            }
                        } else {
                            Button(action: {
                                // goto: camera function
                            }) {
                                Image(systemName: "camera")
                                    .imageScale(.large)
                                    .foregroundStyle(Color("IconGreen"))
                                    .padding(.trailing, 8)
                            }
                        }
 
                        }
                        
                    }
            if !searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                // if search content is not empty, do something here.....
                //let viewName = String(describing: type(of: self))
                
                if parentViewName == "SearchView" {
                    // jump to search result view: SearchResultView
                    NavigationLink(destination: SearchResultView(searchText: $searchText, hasResult: hasResult)){
                        Text("Search")
                            .padding(10)
                            .background(Color("IconGreen"))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    
                } else {
                    Button(action: {
                        // test code: fetch parentView name
                        //self.searchText = parentViewName
                        
                        // do something: load search results to the list below search bar.

                        // test code: toggle a bool var to simulate if result has been found, then show result based on it
                        hasResult.toggle()
                        
                        }) {
                            Text("Search")
                        }
                        .padding(10)
                        .background(Color("IconGreen"))
                        .cornerRadius(10)
                        .foregroundStyle(Color.white)
                }
            }
        }
        .padding()

                //.border(Color.red)
            // when editing
//                .onTapGesture {
//                    self.isEditing = true
//                }
            
            // search button "go"
            /*if isEditing {
                Button(action: {
                    self.isEditing = false
                    self.searchText = ""
                    
                    // if search content is not empty, do something here.....
                    
                }) {
                    Text("Go")
                }
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
            }*/
            
            

            
        }
            
    }
    
    
//    func getFocus(focused: Bool) {
//        self.isEditing = focused
//    }


#Preview {
    @Previewable @State var searchText: String = ""
    @Previewable @State var viewName: String = ""
    @Previewable @State var hasResult: Bool = false
    
    SearchBar(searchText: $searchText, hasResult: $hasResult, parentViewName: $viewName)
}