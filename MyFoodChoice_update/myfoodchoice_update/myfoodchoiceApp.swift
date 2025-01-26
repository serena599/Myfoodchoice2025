//
//  RecipeSearchApp.swift
//  RecipeSearch
//
//  Created by chris on 9/12/2024.
//

import SwiftUI

@main
struct myfoodchoiceApp: App {
    @State private var isLoggedIn = false // 用于控制登录状态

    var body: some Scene {
        WindowGroup {
            // 根据登录状态决定显示的页面
            if isLoggedIn {
                MainView() // 登录后跳转到主页面
            } else {
                LoginView(isLoggedIn: $isLoggedIn) // 绑定登录状态
            }
        }
    }
}

