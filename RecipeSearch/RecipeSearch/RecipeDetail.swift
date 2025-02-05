//
//  RecipeDetail.swift
//  RecipeSearch
//
//  Created by chris on 15/12/2024.
//

import SwiftUI

struct RecipeDetail: View {
    @State var recipeToDisplay: Recipe = Recipe(recipe_ID: 1, recipe_name: "Grilled Meat and Egg Salad with Avocado", image_URL: "https://i2.chuimg.com/d7cb9c0430e34c69aca5f4ac7a2994a6_606w_404h.jpg", traffic_lights:
                                                    ["Saturates": "green",
                                                     "Sugar": "green",
                                                     "Salt": "green",
                                                     "Fat": "green",
                                                     "Source": "link:<www.123123123.com>"],
                                                food_type: "breakfast"
    )
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    // recipe info: image, title, ingredients and favourate button
                    AsyncImage(url: URL(string: recipeToDisplay.image_URL)) { phase in
                                if let image = phase.image {
                                    image.resizable().scaledToFit()
                                } else if phase.error != nil {
                                    Image("ImagePlaceholder").resizable()
                                } else {
                                    ProgressView() // 显示加载指示器
                                }
                            }
                            .frame(width: 110, height: 140)
                            //.clipShape(Circle())
                    
//                    recipeToDisplay.image_URL
//                        .resizable()
//                        .frame(width: 110, height: 140)
                   
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text(recipeToDisplay.recipe_name)
                                //.font(.title3)
                                //.lineLimit(2)
                                //.fontWeight(.bold)
                                //.border(Color.red)
                            
                           Spacer()
                            
//                            VStack {
//                                
//                                Image(systemName: recipeToDisplay.isCollected ? "suit.heart.fill" : "suit.heart")
//                                        .imageScale(.large)
//                                        .tint(Color("IconGreen"))
//                                        .foregroundStyle(Color("IconGreen"))
//                                        .onTapGesture {
//                                            recipeToDisplay.isCollected.toggle()
//                                        }
//                                
//                            }
//                            .padding(5)
//                            //.border(Color.red)
                        }

//                        Text(recipeToDisplay.traffic_lights.keys.joined(separator: ","))
//                            .foregroundStyle(.secondary)
//                            .font(.system(size: 15))
                            //.lineLimit(1)
                            //.border(Color.red)
                        
                        Text(recipeToDisplay.instructions)
                            .foregroundStyle(.secondary)
                            .font(.system(size: 15))
                                                       
                    }
                    
                }
                .background(Color("SearchResultBackground"))
                .cornerRadius(15)
                .padding(.bottom, 20)
                .overlay {
                    HStack {
                        Spacer()
                        
                        VStack {
                            Image(systemName: recipeToDisplay.is_recommend ? "suit.heart.fill" : "suit.heart")
                                .imageScale(.large)
                                .tint(Color.green)
                                .foregroundStyle(Color.green)
                                .onTapGesture {
                                    recipeToDisplay.is_recommend.toggle()
                                    
                                    // identify if the current recipe is already added to user's favourate
                                    
                                    // to do: add to user's favourate recipes list ..............
                                    
                                }
                                .padding(5)
                            
                            Spacer()
                        }
                        
                    }
                }
                //.border(Color.red)
                
                HStack {
                    // instructions and icon
                    Image(systemName: "lightbulb.max.fill")
                        .foregroundStyle(Color.yellow)
                    
                    Text("Instructions")
                        .font(.headline)
                    
                    Spacer()
                }
                
                VStack {
                    // steps contents
                    HStack {
                        // step1
                        Text("Step 1: ")
                            .fontWeight(.bold)
                        Text("Prepare the ingredients.")
                        
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                    
                    HStack {
                        // step1
                        Text("Step 2: ")
                            .fontWeight(.bold)
                        Text("Roast the potatoes.")
                        
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    
                    HStack {
                        // step1
                        Text("Step 3: ")
                            .fontWeight(.bold)
                        Text("Cook the beef and shrimp.")
                        
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    
                    HStack {
                        // step1
                        Text("Step 4: ")
                            .fontWeight(.bold)
                        Text("Poach the egg.")
                        
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 10)
                }
                .background(Color("SearchResultBackground"))
                .cornerRadius(20)


            }
            //.border(Color.red)
            
            HStack {
                // instructions and icon
                Image(systemName: "lightbulb.max.fill")
                    .foregroundStyle(Color.yellow)
                
                Text("Traffic Lights")
                    .font(.headline)
                
                Spacer()
            }
            .padding(.top, 20)
            
            VStack {
                // Flavours
                HStack {
                    Text("Beef Salad")
                        .font(.headline)
                        .padding(.horizontal, 10)
                    
                    Spacer()
                }
                .padding(.top, 10)
                .padding(.horizontal, 20)
                
                HStack(spacing: 10) {
                    HStack {
                        Text("Saturates: ")
                            .padding(.horizontal, 5)
                        
                        Spacer()
                           
                        Image(systemName: "circle.fill")
                            .imageScale(.large)
                            .foregroundStyle(Color("IconGreen"))

                    }
                    .padding(5)
                    .frame(maxWidth: 140, maxHeight: 40)
                    .background(
                        Capsule()
                            .stroke(Color.white, lineWidth: 0.8)
                            .background(Color.white)
                    )
                    .clipShape(Capsule())
                    
                    HStack {
                        Text("Salt: ")
                            .padding(.horizontal, 5)
                        
                        Spacer()
                        
                        Image(systemName: "circle.fill")
                            .imageScale(.large)
                            .foregroundStyle(Color("IconGreen"))

                    }
                    .padding(5)
                    .frame(maxWidth: 140, maxHeight: 40)
                    .background(
                        Capsule()
                            .stroke(Color.white, lineWidth: 0.8)
                            .background(Color.white)
                    )
                    .clipShape(Capsule())
                }
                
                HStack(spacing: 10) {
                    HStack {
                        Text("Sugers: ")
                            .padding(.horizontal, 5)
                        
                        Spacer()
                           
                        Image(systemName: "circle.fill")
                            .imageScale(.large)
                            .foregroundStyle(Color("IconGreen"))

                    }
                    .padding(5)
                    .frame(maxWidth: 140, maxHeight: 40)
                    .background(
                        Capsule()
                            .stroke(Color.white, lineWidth: 0.8)
                            .background(Color.white)
                    )
                    .clipShape(Capsule())
                    
                    HStack {
                        Text("Fat: ")
                            .padding(.horizontal, 5)
                           
                        Spacer()
                        
                        Image(systemName: "circle.fill")
                            .imageScale(.large)
                            .foregroundStyle(Color("IconGreen"))

                    }
                    .padding(5)
                    .frame(maxWidth: 140, maxHeight: 40)
                    .background(
                        Capsule()
                            .stroke(Color.white, lineWidth: 0.8)
                            .background(Color.white)
                    )
                    .clipShape(Capsule())
                }
                

                HStack {
                    //Text("Source: ")
                    
                    Text("Source:  www.123123123123123123.com/123123/1231123")
                        .font(.system(size: 15))
                        .onTapGesture {
                            // todo: goto url......
                        }
                }
                .padding(.horizontal, 10)
                .padding()
                
                
                
            }
            .background(Color("SearchResultBackground"))
            .cornerRadius(20)
            
        }
        .padding(.horizontal, 20)
        //.border(Color.red)
        .safeAreaInset(edge: .top, spacing: 0) { // 自定义顶部安全区域
            Color.clear.frame(height: 20) // 模拟一个 50 点的安全区域
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
                                    Text("Recipes")
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
    RecipeDetail()
}
