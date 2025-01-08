//
//  PersonalView.swift
//  RecipeSearch
//
//  Created by chris on 9/12/2024.
//

// haven't been assign to any member yet...

import SwiftUI

struct PersonalView: View {
    @State private var userName = "Amber Smith"
    @State private var joinedYear = "2024"
    @State private var userImage: UIImage? = nil
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // 标题
                Text("MyfoodChioce")
                    .font(.system(size: 20, weight: .medium))
                    .padding(.vertical, 10)
                
                // 用户头像和信息
                VStack(spacing: 10) {
                    if let image = userImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 120, height: 120)
                            .clipShape(Circle())
                    } else {
                        Circle()
                            .fill(Color.gray.opacity(0.2))
                            .frame(width: 120, height: 120)
                            .overlay(
                                Image(systemName: "person.fill")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 50))
                            )
                    }
                    
                    Text(userName)
                        .font(.system(size: 24, weight: .medium))
                    
                    Text("Joined \(joinedYear)")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                }
                .padding(.vertical, 20)
                
                // 菜单列表
                VStack(spacing: 0) {
                    MenuRow(title: "Setting", icon: "gearshape.fill")
                    MenuRow(title: "My Goal", icon: "flag.fill")
                    MenuRow(title: "Medal", icon: "medal.fill")
                    MenuRow(title: "Favorite Recipe", icon: "heart.fill")
                }
                .padding(.top, 20)
                
                Spacer()
            }
            .background(Color.white)
        }
    }
}

// MenuRow组件
struct MenuRow: View {
    let title: String
    let icon: String
    
    var body: some View {
        if title == "Setting" {
            NavigationLink {
                SubSettingView()
            } label: {
                menuRowContent
            }
        } else {
            NavigationLink {
                EmptyView()
            } label: {
                menuRowContent
            }
        }
        Divider()
            .padding(.horizontal, 30)
    }
    
    private var menuRowContent: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.black)
                .frame(width: 30)
            
            Text(title)
                .foregroundColor(.black)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding(.horizontal, 30)
        .frame(height: 50)
    }
}

#Preview {
    PersonalView()
}
