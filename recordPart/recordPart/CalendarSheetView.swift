//
//  Untitled.swift
//  recordProject
//
//  Created by serena on 26/12/2024.
//

import SwiftUI

struct CalendarSheetView: View {
    @Binding var currentDate: Date  // 从主页面绑定的当前日期
    @Binding var isPresented: Bool // 从主页面绑定的弹窗控制

    var body: some View {
        VStack {
            // 顶部导航，包含左右箭头切换日期
            HStack {
                // 左箭头：向前一天
                Button(action: {
                    currentDate = Calendar.current.date(byAdding: .day, value: -1, to: currentDate) ?? currentDate
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.green)
                        .font(.system(size: 20))
                }
                
                Spacer()
                
                // 显示当前日期
                Text(formatDate(currentDate))
                    .font(.system(size: 20, weight: .medium))
                
                Spacer()
                
                // 右箭头：向后一天
                Button(action: {
                    currentDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate) ?? currentDate
                }) {
                    Image(systemName: "chevron.right")
                        .foregroundColor(.green)
                        .font(.system(size: 20))
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 10)
            
            // 日期选择器，显示图形化日期选择器
            DatePicker("Select a date", selection: $currentDate, displayedComponents: .date)
                .datePickerStyle(GraphicalDatePickerStyle())
                .labelsHidden()
                .padding()
            
            Spacer()
            
            // 确认按钮，关闭日历弹窗
            Button(action: {
                isPresented = false
            }) {
                Text("Done")
                    .font(.system(size: 18))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color.green)
                    .cornerRadius(8)
                    .padding(.horizontal, 20)
            }
            .padding(.bottom, 20)
        }
    }
    
    // 日期格式化方法
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM, yyyy"
        return formatter.string(from: date)
    }
}



