import SwiftUI

struct SubSettingView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var selectedGuidance = "Australian Dietary Guidelines"
    @State private var notificationEnabled = true
    @State private var selectedTime = "Daily"
    @State private var selectedContent = "Progress Remainder"
    @State private var gpsEnabled = true
    @State private var smartDeviceEnabled = true
    @State private var screenEnabled = true
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(alignment: .leading, spacing: 30) {
                    // 添加顶部空间
                    Color.clear.frame(height: 20)
                    
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
                                .toggleStyle(SwitchToggleStyle(tint: Color("IconGreen")))
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
        }
        .background(Color.white)
        .navigationTitle("Setting")
        .navigationBarTitleDisplayMode(.inline)
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
                    .stroke(isSelected ? Color("IconGreen") : Color.gray, lineWidth: 1)
                    .frame(width: 20, height: 20)
                    .overlay(
                        Circle()
                            .fill(isSelected ? Color("IconGreen") : Color.clear)
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
                .toggleStyle(SwitchToggleStyle(tint: Color("IconGreen")))
        }
    }
}

#Preview {
    SubSettingView()
} 