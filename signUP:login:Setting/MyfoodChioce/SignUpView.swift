import SwiftUI

struct SignUpView: View {
    @State private var currentTime = Date()
    @State private var username = ""
    @State private var email = ""
    @State private var phone = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Color(hex: "91C788")
                .ignoresSafeArea()
            
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
                
                VStack(spacing: 0) {
                    Text("MyfoodChoice")
                        .font(.system(size: 43, weight: .bold))
                        .foregroundColor(.white)
                        .shadow(color: .white, radius: 1)
                        .padding(.top, 60)
                        .padding(.bottom, 90)
               
                    VStack(spacing: 16) {
                        InputField(icon: "person", placeholder: "Username", text: $username)
                        InputField(icon: "envelope", placeholder: "Email", text: $email)
                        InputField(icon: "phone", placeholder: "Phone", text: $phone)
                        SecureInputField(icon: "lock", placeholder: "Password", text: $password)
                        SecureInputField(icon: "lock", placeholder: "Confirm Password", text: $confirmPassword)
                    }
                    
            
                    Button(action: {
                    }) {
                        Text("SIGN UP")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(Color(hex: "91C788"))
                            .frame(maxWidth: .infinity)
                            .frame(height: 45)
                            .background(Color.white)
                            .cornerRadius(8)
                    }
                    .padding(.top, 50)
                }
                .padding(.horizontal, 40)
                
                Spacer()
            }
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

// 自定义输入框组件
struct InputField: View {
    let icon: String
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.white)
                .frame(width: 20)
            
            TextField("", text: $text)
                .foregroundColor(.white)
                .accentColor(.white)
                .textPlaceholder(when: text.isEmpty) {
                    Text(placeholder)
                        .foregroundColor(.white.opacity(0.8))
                }
        }
        .padding(.horizontal, 12)
        .frame(height: 45)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.white, lineWidth: 1)
        )
    }
}

// 自定义安全输入框组件
struct SecureInputField: View {
    let icon: String
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.white)
                .frame(width: 20)
            
            SecureField("", text: $text)
                .foregroundColor(.white)
                .accentColor(.white)
                .textPlaceholder(when: text.isEmpty) {
                    Text(placeholder)
                        .foregroundColor(.white.opacity(0.8))
                }
        }
        .padding(.horizontal, 12)
        .frame(height: 45)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.white, lineWidth: 1)
        )
    }
}

// Placeholder修饰符
extension View {
    func textPlaceholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
        
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

#Preview {
    SignUpView()
}
