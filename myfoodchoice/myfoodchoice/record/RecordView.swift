//
//  RecordView.swift
//  RecipeSearch
//
//  Created by chris on 9/12/2024.
//

import SwiftUI
import Charts

struct RecordView: View {
    @State private var currentDate = Date()
    @State private var isCalendarPresented = false
    
    var body: some View {
        VStack(spacing: 0) {
            // 顶部导航栏
            HStack {
                Spacer()
                Text("Record")
                    .font(.system(size: 20, weight: .medium))
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            
            // 餐食卡片部分
            ScrollView {
                VStack(spacing: 12) {
                    // 图表部分
                    FoodTrackingChart()
                        .padding(.horizontal)
                    
                    // 日期部分：包含左右箭头和日历按钮
                    HStack(spacing: 15) {
                        Button(action: {
                            currentDate = Calendar.current.date(byAdding: .day, value: -1, to: currentDate) ?? currentDate
                        }) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 24))
                                .foregroundColor(.gray)
                                .padding(8)
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(8)
                        }
                        
                        Button(action: {
                            isCalendarPresented = true
                        }) {
                            HStack {
                                Image(systemName: "calendar")
                                    .font(.system(size: 24))
                                    .foregroundColor(.gray)
                                    .padding(8)
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(8)
                                Text(formatDate(currentDate))
                                    .font(.system(size: 18))
                                    .foregroundColor(.black)
                            }
                        }
                        
                        Button(action: {
                            currentDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate) ?? currentDate
                        }) {
                            Image(systemName: "chevron.right")
                                .font(.system(size: 24))
                                .foregroundColor(.gray)
                                .padding(8)
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(8)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    
                    // 餐食记录部分
                    NavigationLink(destination: MealDetailView(mealType: "Breakfast")) {
                        MealCard(title: "Breakfast", color: .green)
                    }
                    NavigationLink(destination: MealDetailView(mealType: "Lunch")) {
                        MealCard(title: "Lunch", color: .orange)
                    }
                    NavigationLink(destination: MealDetailView(mealType: "Dinner")) {
                        MealCard(title: "Dinner", color: .pink)
                    }
                    NavigationLink(destination: MealDetailView(mealType: "Snack")) {
                        MealCard(title: "Snack", color: .purple)
                    }
                }
                .padding()
            }
        }
        .sheet(isPresented: $isCalendarPresented) {
            CalendarSheetView(currentDate: $currentDate, isPresented: $isCalendarPresented)
        }
    }
    
    // 日期格式化方法
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM, EEEE" // 如：27 Dec, Friday
        return formatter.string(from: date)
    }
}

// 从FoodRecordView移植的相关组件
struct FoodEntry: Identifiable {
    let id = UUID()
    let category: String
    let day: String
    let amount: Double
}

struct FoodTrackingChart: View {
    let data: [FoodEntry] = [
        // Vegetables
        FoodEntry(category: "Vegetables", day: "Day 1", amount: 6),
        FoodEntry(category: "Vegetables", day: "Day 2", amount: 4),
        FoodEntry(category: "Vegetables", day: "Day 3", amount: 7),
        FoodEntry(category: "Vegetables", day: "Day 4", amount: 5),
        FoodEntry(category: "Vegetables", day: "Day 5", amount: 8),
        
        // Grains
        FoodEntry(category: "Grains", day: "Day 1", amount: 8),
        FoodEntry(category: "Grains", day: "Day 2", amount: 12),
        FoodEntry(category: "Grains", day: "Day 3", amount: 6),
        FoodEntry(category: "Grains", day: "Day 4", amount: 9),
        FoodEntry(category: "Grains", day: "Day 5", amount: 7),
        
        // Fruit
        FoodEntry(category: "Fruit", day: "Day 1", amount: 4),
        FoodEntry(category: "Fruit", day: "Day 2", amount: 3),
        FoodEntry(category: "Fruit", day: "Day 3", amount: 5),
        FoodEntry(category: "Fruit", day: "Day 4", amount: 4),
        FoodEntry(category: "Fruit", day: "Day 5", amount: 3),
        
        // Meat
        FoodEntry(category: "Meat", day: "Day 1", amount: 5),
        FoodEntry(category: "Meat", day: "Day 2", amount: 6),
        FoodEntry(category: "Meat", day: "Day 3", amount: 4),
        FoodEntry(category: "Meat", day: "Day 4", amount: 5),
        FoodEntry(category: "Meat", day: "Day 5", amount: 4),
    ]
    
    var body: some View {
        VStack {
            Text("Food Category Tracking")
                .font(.headline)
                .padding(.top)
            
            Chart(data) { entry in
                LineMark(
                    x: .value("Day", entry.day),
                    y: .value("Amount", entry.amount)
                )
                .foregroundStyle(by: .value("Category", entry.category))
            }
            .chartForegroundStyleScale([
                "Vegetables": Color.green,
                "Grains": Color.orange,
                "Fruit": Color.purple,
                "Meat": Color.red
            ])
            .frame(height: 200)
            .padding()
            
            // Category Icons
            HStack(spacing: 20) {
                CategoryIcon(icon: "leaf.fill", color: .green, text: "Vegetables")
                CategoryIcon(icon: "circle.fill", color: .orange, text: "Grains")
                CategoryIcon(icon: "apple.logo", color: .purple, text: "Fruit")
                CategoryIcon(icon: "fork.knife", color: .red, text: "Meat")
            }
            .padding(.bottom)
        }
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 5)
    }
}

struct CategoryIcon: View {
    let icon: String
    let color: Color
    let text: String
    
    var body: some View {
        VStack {
            Image(systemName: icon)
                .foregroundColor(color)
                .font(.system(size: 20))
            Text(text)
                .font(.caption)
                .foregroundColor(.gray)
        }
    }
}

#Preview {
    RecordView()
}
