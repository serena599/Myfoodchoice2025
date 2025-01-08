//
//  BottomTabViews.swift
//  RecipeSearch
//
//  Created by chris on 9/12/2024.
//

import SwiftUI

struct BottomTabViews: View {
    @State var selectedTab: Int = 2
    
    var body: some View {
        NavigationStack {  // 保留 NavigationStack 以支持导航
            VStack(spacing: 0) {
                // 主要内容区域
                TabView(selection: $selectedTab) {
                    HomeView()
                        .tag(1)
                    SearchView()
                        .tag(2)
                    CameraView()
                        .tag(3)
                    RecordView()
                        .tag(4)
                    PersonalView()
                        .tag(5)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
                // 自定义底部导航栏
                HStack(spacing: 0) {
                    GeometryReader { geometry in
                        HStack(spacing: 0) {
                            TabBarButtonView(icon: "house.fill", isSelected: selectedTab == 1)
                                .onTapGesture { selectedTab = 1 }
                                .offset(y: -8)
                            
                            TabBarButtonView(icon: "magnifyingglass", isSelected: selectedTab == 2)
                                .onTapGesture { selectedTab = 2 }
                                .offset(y: -8)
                            
                            Button(action: { selectedTab = 3 }) {
                                ZStack {
                                    Circle()
                                        .fill(Color("IconGreen"))
                                        .frame(width: 55, height: 55)
                                    
                                    Image(systemName: "camera")
                                        .font(.system(size: 20))
                                        .foregroundColor(.white)
                                }
                            }
                            .offset(y: -10)
                            .frame(width: geometry.size.width / 5)
                            
                            TabBarButtonView(icon: "book", isSelected: selectedTab == 4, strokeStyle: true)
                                .onTapGesture { selectedTab = 4 }
                                .offset(y: -8)
                            
                            TabBarButtonView(icon: "person.fill", isSelected: selectedTab == 5)
                                .onTapGesture { selectedTab = 5 }
                                .offset(y: -8)
                        }
                        .frame(maxHeight: .infinity)
                        .frame(width: geometry.size.width)
                    }
                }
                .frame(height: 50)
                .padding(.horizontal, 30)
                .padding(.bottom, 20)
            }
        }
    }
}

struct TabBarButtonView: View {
    let icon: String
    let isSelected: Bool
    var strokeStyle: Bool = false
    
    var body: some View {
        Image(systemName: icon)
            .font(.system(size: 20))
            .foregroundColor(isSelected ? Color("IconGreen") : .gray)
            .frame(maxWidth: .infinity)
    }
}

#Preview {
    BottomTabViews()
}
