//
//  MyFoodChoiceApp.swift
//  MyFoodChoice
//
//  Created by CHIHCHEN on 2024/12/11.
//

import SwiftUI

@main
struct MyFoodChoiceApp: App {
    var body: some Scene {
        WindowGroup {
            GoalSettingView()
            GoalTrackingView()
            MedalView()// Replace ContentView with GoalSettingView
        }
    }
}

