//
//  HomeView.swift
//  RecipeSearch
//
//  Created by chris on 9/12/2024.
//

//import SwiftUI
//
//struct HomeView: View {
//    var body: some View {
//        Text("HomeView")
//    }
//}
//
//#Preview {
//    HomeView()
//}

// test purpose, will be replaced by Mia & Serena's code of UI part 1

import SwiftUI

struct HomeView: View {
    var body: some View {
        //Text("HomeView")
        
        NavigationStack() {
            ViewA()
        }
    }
}

#Preview {
    HomeView()
}


struct ViewA: View {
    var body: some View {
        VStack(spacing: 20) {
//                    Text("This is View A")
//                        .font(.largeTitle)
                    
                    NavigationLink(destination: ViewB()) {
                        Text("Go to View B")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
        //.navigationTitle("View A")
    }
}

struct ViewB: View {
    let screenWidth = UIScreen.main.bounds.width
    @Environment(\.presentationMode) var presentationMode // 用于手动控制返回

    var body: some View {
        VStack {
            Text("This is View B，screen width is \(screenWidth)")
        }
        //.navigationTitle("View B")
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
                                    Text("Centered Title 12312312312312321")
                                        .font(.headline) // 可以调整样式
                                        .bold()
                                }
                            }
                    }
                    .border(Color.red)
                }
                .tint(Color.black)
            }
        }
    }
}

struct ViewC: View {
    var body: some View {
        VStack(spacing: 20) {
                    Text("This is View C")
                        .font(.largeTitle)
                    
                    NavigationLink(destination: ViewA()) {
                        Text("Go to View A")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
                .navigationTitle("View C")
    }
}
