//
//  MedalView.swift
//  MyFoodChoice
//
//  Created by CHIHCHEN on 2024/12/14.
//

import SwiftUI

struct MedalView: View {
    var milestoneBadges: [Badge] = [
        Badge(title: "1 Day Completed", imageName: "medal1.jpg"),
        Badge(title: "7 Days Completed", imageName: "medal2")
    ]
    
    var stageAchievements: [Badge] = [
        Badge(title: "Gold Level Achievement", imageName: "stage1"),
        Badge(title: "Wellness Warrior", imageName: "stage2"),
        Badge(title: "Nutrition Mastery", imageName: "stage3"),
        Badge(title: "Superfood Hero", imageName: "stage4")
    ]
    
    var body: some View {
        VStack(alignment: .leading) {
            // Title
            Text("Medal")
                .font(.title)
                .bold()
                .padding()
            
            ScrollView {
                // Milestone Badges Section
                VStack(alignment: .leading, spacing: 10) {
                    Text("Milestone Badges")
                        .font(.headline)
                        .padding(.leading)
                    
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                        ForEach(milestoneBadges) { badge in
                            BadgeView(badge: badge)
                        }
                    }
                    .padding()
                }
                
                // Stage Achievements Section
                VStack(alignment: .leading, spacing: 10) {
                    Text("Stage Achievements")
                        .font(.headline)
                        .padding(.leading)
                    
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                        ForEach(stageAchievements) { badge in
                            BadgeView(badge: badge)
                        }
                    }
                    .padding()
                }
            }
        }
    }
}

struct Badge: Identifiable {
    let id = UUID()
    let title: String
    let imageName: String
}

struct BadgeView: View {
    var badge: Badge
    
    var body: some View {
        VStack {
            Image(badge.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .clipShape(Circle())
                .shadow(radius: 5)
            
            Text(badge.title)
                .font(.footnote)
                .multilineTextAlignment(.center)
                .padding(.top, 5)
        }
    }
}

struct MedalView_Previews: PreviewProvider {
    static var previews: some View {
        MedalView()
    }
}
