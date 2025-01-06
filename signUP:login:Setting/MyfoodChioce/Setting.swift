import SwiftUI

struct ProfileView: View {
    @State private var currentTime = Date()
    @State private var userName = "Amber Smith"
    @State private var joinedYear = "2024"
    @State private var userImage: UIImage? = nil
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                HStack {
                    Text(timeString(from: currentTime))
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    HStack(spacing: 5) {
                        Image(systemName: "cellullar")
                            .foregroundColor(.black)
                        Image(systemName: "wifi")
                            .foregroundColor(.black)
                        Image(systemName: "battery.100")
                            .foregroundColor(.black)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 5)
                
                HStack {
                    Button(action: {
                    }) {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.black)
                            .font(.system(size: 20))
                    }
                    
                    Spacer()
                    
                    Text("MyfoodChioce")
                        .font(.system(size: 20, weight: .medium))
                    
                    Spacer()
                }
                .padding(.horizontal)
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
                    MenuRow(title: "Setting", icon: "gearshape.fill")
                    MenuRow(title: "Favorite Recipe", icon: "heart.fill")
                }
                .padding(.top, 20)
                
                Spacer()
                
                // 底部导航栏
                HStack(spacing: 0) {
                    GeometryReader { geometry in
                        HStack(spacing: 0) {
                            TabBarButton(icon: "house.fill", isSelected: false)
                                .offset(y: -8)
                            TabBarButton(icon: "magnifyingglass", isSelected: false)
                                .offset(y: -8)
                            
                            // 中间的相机按钮
                            Button(action: {
                                // 相机操作
                            }) {
                                ZStack {
                                    Circle()
                                        .fill(Color(hexCode: "91C788"))
                                        .frame(width: 55, height: 55)
                                    
                                    Image(systemName: "camera")
                                        .font(.system(size: 20))
                                        .foregroundColor(.white)
                                }
                            }
                            .offset(y: -10)
                            .frame(width: geometry.size.width / 5)
                            
                            TabBarButton(icon: "book", isSelected: false, strokeStyle: true)
                                .offset(y: -8)
                            TabBarButton(icon: "person.fill", isSelected: true)
                                .offset(y: -8)
                        }
                        .frame(maxHeight: .infinity)
                        .frame(width: geometry.size.width)
                    }
                }
                .frame(height: 50)
                .padding(.horizontal)
                .padding(.bottom, 20)
            }
            .background(Color.white)
        }
        .onReceive(timer) { input in
            currentTime = input
        }
    }
    
    private func timeString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
}

// MenuRow组件
struct MenuRow: View {
    let title: String
    let icon: String
    
    var body: some View {
        NavigationLink(destination: EmptyView()) {
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
        Divider()
            .padding(.horizontal, 30)
    }
}

// TabBarButton组件
struct TabBarButton: View {
    let icon: String
    let isSelected: Bool
    var strokeStyle: Bool = false
    
    var body: some View {
        Button(action: {
            // 处理点击事件
        }) {
            Image(systemName: icon)
                .font(.system(size: 24))
                .foregroundColor(isSelected ? Color(hexCode: "91C788") : .gray)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .contentShape(Rectangle())
        }
    }
}

// Color扩展
extension Color {
    init(hexCode: String) {
        let hex = hexCode.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

#Preview {
    ProfileView()
}
