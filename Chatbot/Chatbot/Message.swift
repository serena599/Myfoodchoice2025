//
//  Message.swift
//  Chatbot
//
//  Created by chris on 14/1/2025.
//

import SwiftUI

// 消息模型
struct Message: Identifiable, Equatable{
    let id = UUID()
    let text: String
    let isUser: Bool
    let avatar: String // 头像图片名称
    let timestamp: Date
}
