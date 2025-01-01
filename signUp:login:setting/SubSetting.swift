import SwiftUI

struct SettingView: View {
    @State private var currentTime = Date()
    @State private var selectedGuidance = "Australian Dietary Guidelines"
    @State private var notificationEnabled = true
    @State private var selectedTime = "Daily"
    @State private var selectedContent = "Progress Remainder"
    @State private var gpsEnabled = true
    @State private var smartDeviceEnabled = true
    @State private var screenEnabled = true
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
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
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                        .font(.system(size: 20))
                }
                
                Spacer()
                
                Text("Setting")
                    .font(.system(size: 20, weight: .medium))
                
                Spacer()
            }
            .padding(.horizontal, 30)
            .padding(.vertical, 10)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 30) {
                    // Guidance Preference
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Guidance Preference")
                            .font(.system(size: 20, weight: .bold))
                        
                        VStack(alignment: .leading, spacing: 15) {
                            RadioButton(title: "Australian Dietary Guidelines", isSelected: selectedGuidance == "Australian Dietary Guidelines") {
                                selectedGuidance = "Australian Dietary Guidelines"
                            }
                            
                            RadioButton(title: "Mediterranean Style", isSelected: selectedGuidance == "Mediterranean Style") {
                                selectedGuidance = "Mediterranean Style"
                            }
                            
                            RadioButton(title: "Plant-based Style", isSelected: selectedGuidance == "Plant-based Style") {
                                selectedGuidance = "Plant-based Style"
                            }
                        }
                    }
                    
                    // Notification Setting
                    VStack(alignment: .leading, spacing: 15) {
                        HStack(spacing: 15) {
                            Text("Notification Setting")
                                .font(.system(size: 20, weight: .bold))
                                .lineLimit(1)
                                .fixedSize()
                            
                            Spacer()
                            
                            Toggle("", isOn: $notificationEnabled)
                                .toggleStyle(SwitchToggleStyle(tint: Color.hexStringInit("91C788")))
                        }
                        
                        if notificationEnabled {
                            VStack(alignment: .leading, spacing: 15) {
                                Text("Time")
                                    .font(.system(size: 16, weight: .medium))
                                
                                HStack(spacing: 30) {
                                    RadioButton(title: "Daily", isSelected: selectedTime == "Daily") {
                                        selectedTime = "Daily"
                                    }
                                    
                                    RadioButton(title: "Weekly", isSelected: selectedTime == "Weekly") {
                                        selectedTime = "Weekly"
                                    }
                                }
                                
                                Text("Content")
                                    .font(.system(size: 16, weight: .medium))
                                    .padding(.top, 5)
                                
                                VStack(alignment: .leading, spacing: 15) {
                                    RadioButton(title: "Progress Remainder", isSelected: selectedContent == "Progress Remainder") {
                                        selectedContent = "Progress Remainder"
                                    }
                                    
                                    RadioButton(title: "Food Logging", isSelected: selectedContent == "Food Logging") {
                                        selectedContent = "Food Logging"
                                    }
                                    
                                    RadioButton(title: "Weekly Summary of Progress", isSelected: selectedContent == "Weekly Summary of Progress") {
                                        selectedContent = "Weekly Summary of Progress"
                                    }
                                }
                            }
                        }
                    }
                    
                    // Other Settings
                    ToggleSetting(title: "GPS", isOn: $gpsEnabled)
                    ToggleSetting(title: "Smart Device", isOn: $smartDeviceEnabled)
                    ToggleSetting(title: "Screen On/Off", isOn: $screenEnabled)
                }
                .padding(.horizontal, 30)
            }
            
            Spacer()
            
            // 底部导航栏
            HStack(spacing: 0) {
                GeometryReader { geometry in
                    HStack(spacing: 0) {
                        TabBarButtonView(icon: "house.fill", isSelected: false)
                            .offset(y: -8)
                        TabBarButtonView(icon: "magnifyingglass", isSelected: false)
                            .offset(y: -8)
                        
                        // 中间的相机按钮
                        Button(action: {
                            // 相机操作
                        }) {
                            ZStack {
                                Circle()
                                    .fill(Color.hexStringInit("91C788"))
                                    .frame(width: 55, height: 55)
                                
                                Image(systemName: "camera")
                                    .font(.system(size: 20))
                                    .foregroundColor(.white)
                            }
                        }
                        .offset(y: -10)
                        .frame(width: geometry.size.width / 5)
                        
                        TabBarButtonView(icon: "book", isSelected: false, strokeStyle: true)
                            .offset(y: -8)
                        TabBarButtonView(icon: "person.fill", isSelected: true)
                            .offset(y: -8)
                    }
                    .frame(maxHeight: .infinity)
                    .frame(width: geometry.size.width)
                }
            }
            .frame(height: 50)
            .padding(.horizontal, 30)
            .padding(.bottom, 20)
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

// 单选按钮组件
struct RadioButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 10) {
                Circle()
                    .stroke(isSelected ? Color.hexStringInit("91C788") : Color.gray, lineWidth: 1)
                    .frame(width: 20, height: 20)
                    .overlay(
                        Circle()
                            .fill(isSelected ? Color.hexStringInit("91C788") : Color.clear)
                            .frame(width: 14, height: 14)
                    )
                
                Text(title)
                    .foregroundColor(.black)
            }
        }
    }
}

// 开关设置组件
struct ToggleSetting: View {
    let title: String
    @Binding var isOn: Bool
    
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 20, weight: .bold))
            Spacer()
            Toggle("", isOn: $isOn)
                .toggleStyle(SwitchToggleStyle(tint: Color.hexStringInit("91C788")))
        }
    }
}

// 底部标签栏按钮组件
struct TabBarButtonView: View {
    let icon: String
    let isSelected: Bool
    var strokeStyle: Bool = false
    
    var body: some View {
        Button(action: {
            // 处理点击事件
        }) {
            Image(systemName: icon)
                .font(.system(size: 24))
                .foregroundColor(isSelected ? Color.hexStringInit("91C788") : .gray)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .contentShape(Rectangle())
        }
    }
}

// Color扩展
extension Color {
    static func hexStringInit(_ hex: String) -> Color {
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

        return Color(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

#Preview {
    SettingView()
}
