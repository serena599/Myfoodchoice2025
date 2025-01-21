//
//  MessageView.swift
//  Chatbot
//
//  Created by chris on 14/1/2025.
//

import SwiftUI

struct MessageView: View {
    let message: Message

        var body: some View {
            VStack {
                // 使用 HStack 和 Spacer 使时间居中
                HStack {
                    Spacer()
                    Text(formatTimestamp(message.timestamp))  // 时间信息居中
                        .font(.footnote)
                        .foregroundColor(.gray)
                    Spacer()
                }
                HStack(alignment: .bottom, spacing: 8) {
                    if message.isUser {
                        Spacer()
                        VStack(alignment: .trailing, spacing: 4) {
                            Text(message.text)
                                .padding()
                                .background(Color("BubbleBlue"))
                                //.foregroundColor(.black)
                                .cornerRadius(10)
                        }
                        Image(systemName: message.avatar)
                            .resizable()
                            .frame(width: 40, height: 40)
                    } else {
                        Image(systemName: message.avatar)
                            .resizable()
                            .frame(width: 40, height: 40)
                        VStack(alignment: .leading, spacing: 4) {
                            Text(message.text)
                                .padding()
                                .background(Color("BubbleGray"))
                                //.foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        Spacer()
                    }
                }
                
            }
        }

        private func formatTimestamp(_ date: Date) -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE h:mm a"  // 格式化为 "Wed 8:21 AM"
            return formatter.string(from: date)
        }
}

#Preview {
    MessageView(message: Message(text: "abc？", isUser: false, avatar: "person.circle.fill", timestamp: Date()))
}
