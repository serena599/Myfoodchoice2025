//
//  Untitled.swift
//  recordProject
//
//  Created by serena on 26/12/2024.
//

import SwiftUI

struct TabBarButtonView: View {
    let icon: String
    let isSelected: Bool
    var strokeStyle: Bool = false

    var body: some View {
        Button(action: {}) {
            Image(systemName: icon)
                .font(.system(size: 24))
                .foregroundColor(isSelected ? Color.hexStringInit("91C788") : .gray)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .contentShape(Rectangle())
        }
    }
}

