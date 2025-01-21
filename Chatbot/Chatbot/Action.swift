//
//  Action.swift
//  Chatbot
//
//  Created by chris on 15/1/2025.
//

import SwiftUI

struct Action: Identifiable {
    let id = UUID()
    let title: String
    let destination: AnyView // 使用 AnyView 以支持不同的目标 View
}
