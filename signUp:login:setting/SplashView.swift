import SwiftUI

struct SplashView: View {
    @State private var currentTime = Date()
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(hex: "91C788")
                    .ignoresSafeArea()
                
                VStack {
                    HStack {
                        Text(timeString(from: currentTime))
                            .foregroundColor(.black)
                        
                        Spacer()
                        
                        HStack(spacing: 5) {
                            Image(systemName: "cellullar")
                            Image(systemName: "wifi")
                            Image(systemName: "battery.100")
                        }
                        .foregroundColor(.black)
                    }
                    .padding(.horizontal)
                    .padding(.top, 5)
                    
                    Spacer()
                    Text("MyfoodChoice")
                        .font(.system(size: 43, weight: .bold))
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.2), radius: 2, x: 0, y: 2)
                        .offset(y: -55)
                    
                    Spacer()
                }
            }
            .onReceive(timer) { input in
                currentTime = input
            }
            .onAppear {

                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                }
            }
        }
    }
    
    // 格式化时间的辅助函数
    private func timeString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
}

// 十六进制颜色转换扩展
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
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
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

#Preview {
    SplashView()
}
