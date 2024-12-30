//
//  MealCard.swift
//  recordProject
//
//  Created by serena on 26/12/2024.
//

import SwiftUI

struct MealCard: View {
    let title: String
    let color: Color

    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(color)
                .padding(.leading)
            Spacer()
        }
        .frame(height: 60)
        .background(color.opacity(0.1))
        .cornerRadius(12)
    }
}

