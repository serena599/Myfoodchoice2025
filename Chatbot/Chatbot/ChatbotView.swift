//
//  ChatbotView.swift
//  Chatbot
//
//  Created by chris on 14/1/2025.
//

import SwiftUI

// 主视图
struct ChatBotView: View {
    @State private var messages: [Message] = [
            Message(
                text: "Welcome to the Nutrition Management Assistant! You can enter the following commands: \n1: Food Component Analysis \n2: Record Food Intake \n3: Set your goal \n4: Search recipes \n5: Edit Personal Information",
                isUser: false,
                avatar: "person.circle.fill",
                timestamp: Date()
            )
        ]
        @State private var actions: [Action] = []
        @State private var userInput: String = ""
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationStack {
                    VStack {
                        ScrollViewReader { proxy in
                            ScrollView {
                                LazyVStack(alignment: .leading, spacing: 8) {
                                    ForEach(messages) { message in
                                        MessageView(message: message)
                                    }
                                }
                                .padding()
                            }
                            .onAppear {
                                scrollToBottom(proxy: proxy)
                            }
                            .onChange(of: messages) {
                                scrollToBottom(proxy: proxy)
                            }
                        }
                        
                        VStack {
                            // 渲染跳转按钮
                            ForEach(actions) { action in
                                NavigationLink(destination: action.destination) {
                                    Text(action.title)
                                        .padding()
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                            }
                        }
                        .padding()

                        HStack {
                            TextField("Type a message...", text: $userInput)
                                .padding()
                                //.background(Color.gray.opacity(0.1))
                                //.cornerRadius(30)
                                .overlay(
//                                        RoundedRectangle(cornerRadius: 30)
//                                            .stroke(Color.gray, lineWidth: 2) // 边框颜色和宽度
                                    HStack {
                                        Spacer()
                                        
                                        Button(action: {
                                            // goto: camera function
                                        }) {
                                            Image(systemName: "microphone") // 搜索图标
                                                .imageScale(.large)
                                                .foregroundColor(.gray)
                                                .padding(.trailing, 30)
                                        }
                                    }
                                )
                                .overlay(
                                    // 外边框颜色
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(Color.gray, lineWidth: 2)
                                )
                                .frame(height: 10)
                                .frame(maxHeight: 30)
                        

                            Button(action: sendMessage) {
                                Text("Send")
                                    .padding()
                                    .background(Color.green)
                                    .foregroundColor(.white)
                                    .cornerRadius(30)
                            }
                        }
                        .padding()
                    }
//                    .navigationTitle("Chatbot")
//                    .navigationBarTitleDisplayMode(.inline)
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
                                                Text("Chatbot")
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
    
    private func formatTimestamp(_ date: Date) -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            return formatter.string(from: date)
        }
    
    // 滚动到最新消息
    private func scrollToBottom(proxy: ScrollViewProxy) {
        if let lastMessage = messages.last {
            DispatchQueue.main.async {
                withAnimation {
                    proxy.scrollTo(lastMessage.id, anchor: .bottom)
                }
            }
        }
    }
    
    // 发送消息
    private func sendMessage() {
        guard !userInput.isEmpty else { return }
        let userMessage = Message(
            text: userInput,
            isUser: true,
            avatar: "person.crop.circle.fill",
            timestamp: Date()
        )
        messages.append(userMessage)

        // 模拟获取机器人回复
        let botReply = getBotReply(for: userInput)
        messages.append(Message(
            text: botReply,
            isUser: false,
            avatar: "person.circle.fill",
            timestamp: Date()
        ))
        actions = generateActions(for: userInput)
        
        userInput = ""
    }
    
    // 根据用户输入获取预定义回复
    private func getBotReply(for input: String) -> String {
            let predefinedReplies: [String: String] = [
                "1": "Click button below to Food Analysis:",
                "2": "Click button below to Food Intake Records:",
                "3": "Click button below to Goal Settings:",
                "4": "Click button below to Recipe Search:",
                "5": "Click button below to Edit your Profile:",
                "Help": "Click button below to get help："
            ]
            return predefinedReplies[input] ?? "Sorry, I don't understand that. Or enter the following number for features: \n1: Food Component Analysis \n2: Record Food Intake \n3: Set your goal \n4: Search recipes \n5: Edit Personal Information"
        }
    
    // 根据用户回复信息，生成跳转链接
    private func generateActions(for input: String) -> [Action] {
           switch input.lowercased() {
           case "1":
               return [
                Action(title: "Food Analysis", destination: AnyView(ContentView()))
               ]
           case "2":
               return [
                Action(title: "Intake Record", destination: AnyView(ContentView()))
               ]
           case "3":
               return [
                Action(title: "Set Goals", destination: AnyView(ContentView()))
               ]
           case "4":
               return [
                Action(title: "Search Recipes", destination: AnyView(ContentView()))
               ]
           case "5":
               return [
                Action(title: "Edit Profile", destination: AnyView(ContentView()))
               ]
           case "help":
               return [
                Action(title: "Function Instructions", destination: AnyView(ContentView()))
               ]
           default:
               return [
               ]
           }
       }
}

#Preview {
    ChatBotView()
}
