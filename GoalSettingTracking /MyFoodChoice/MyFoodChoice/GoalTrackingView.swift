//
//  GoalTrackingView.swift
//  MyFoodChoice
//
//  Created by CHIHCHEN on 2024/12/14.
//

import SwiftUI

struct GoalTrackingView: View {
    @State private var progressData: [GoalProgress] = [
        GoalProgress(category: "Vegetables", icon: "leaf", progress: 0.58, serves: "2.9 / 5.0 serves"),
        GoalProgress(category: "Fruit", icon: "apple", progress: 1.0, serves: "3.1 / 2.0 serves"),
        GoalProgress(category: "Grains", icon: "wheat", progress: 0.74, serves: "3.7 / 5.0 serves"),
        GoalProgress(category: "Meat", icon: "drumstick", progress: 1.0, serves: "5.8 / 2.0 serves"),
        GoalProgress(category: "Dairy", icon: "milk", progress: 0.07, serves: "0.2 / 3.0 serves"),
        GoalProgress(category: "Extras", icon: "chocolate.bar", progress: 1.0, serves: "12.1 / 1.0 serves")
    ]
    
    var body: some View {
        VStack {
            // Title
            Text("Goal Tracking")
                .font(.title)
                .bold()
                .padding()
            
            // Progress List
            ScrollView {
                ForEach(progressData) { data in
                    GoalProgressRow(progress: data)
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                }
            }
            
            // Reset Button
            Button(action: {
                // Reset action
            }) {
                Text("Reset My Goal")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            .padding(.vertical)
        }
    }
}

struct GoalProgressRow: View {
    var progress: GoalProgress
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: progress.icon)
                    .foregroundColor(.green)
                    .frame(width: 30, height: 30)
                
                Text(progress.category)
                    .font(.headline)
                
                Spacer()
                
                Text("\(Int(progress.progress * 100))% Completed")
                    .font(.subheadline)
                    .foregroundColor(.green)
            }
            
            Text(progress.serves)
                .font(.footnote)
                .foregroundColor(.gray)
            
            ProgressView(value: progress.progress)
                .tint(progress.progress >= 1.0 ? Color.red : Color.green)
                .padding(.top, 5)
        }
    }
}

struct GoalProgress: Identifiable {
    let id = UUID()
    var category: String
    var icon: String
    var progress: Double
    var serves: String
}

struct GoalTrackingView_Previews: PreviewProvider {
    static var previews: some View {
        GoalTrackingView()
    }
}
