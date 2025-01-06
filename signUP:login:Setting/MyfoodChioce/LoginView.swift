import SwiftUI

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
        
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

struct LoginView: View {
    @State private var currentTime = Date()
    @State private var username = ""
    @State private var password = ""
    
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
                
                // Logo
                Text("MyfoodChoice")
                    .font(.system(size: 43, weight: .bold))
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.2), radius: 2, x: 0, y: 2)
                    .padding(.top, 70)
                    .padding(.bottom, 230)  // 调整了与输入框的距离
                
                // 输入框和按钮
                VStack(spacing: 25) {  // 调整了输入框之间的间距
                    // 用户名输入框
                    HStack {
                        Image(systemName: "person")
                            .foregroundColor(.white)
                            .padding(.leading, 8)
                        TextField("", text: $username)
                            .foregroundColor(.white)
                            .accentColor(.white)  // 光标颜色
                            .placeholder(when: username.isEmpty) {
                                Text("USERNAME")
                                    .foregroundColor(.white.opacity(0.7))
                            }
                    }
                    .frame(height: 45)  // 固定输入框高度
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.white, lineWidth: 1)
                    )
                    .padding(.horizontal, 30)  // 调整了水平边距
                    
                    // 密码输入框
                    HStack {
                        Image(systemName: "lock")
                            .foregroundColor(.white)
                            .padding(.leading, 8)
                        SecureField("", text: $password)
                            .foregroundColor(.white)
                            .accentColor(.white)  // 光标颜色
                            .placeholder(when: password.isEmpty) {
                                Text("PASSWORD")
                                    .foregroundColor(.white.opacity(0.7))
                            }
                    }
                    .frame(height: 45)  // 固定输入框高度
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.white, lineWidth: 1)
                    )
                    .padding(.horizontal, 30)  // 调整了水平边距
                    
                    // 登录按钮
                    Button(action: {
                        // 登录逻辑
                    }) {
                        Text("LOGIN")
                            .font(.system(size: 16))
                            .foregroundColor(Color(hex: "91C788"))
                            .frame(maxWidth: .infinity)
                            .frame(height: 45)
                            .background(Color.white)
                            .cornerRadius(8)
                    }
                    .padding(.horizontal, 30)
                    .padding(.top, 20)
                    
                    // 底部按钮
                    HStack {
                        Button("Sign up") {
                            // 注册逻辑
                        }
                        .foregroundColor(.white)
                        
                        Spacer()
                        
                        Button("Forgot password?") {
                            // 忘记密码逻辑
                        }
                        .foregroundColor(.white)
                    }
                    .padding(.horizontal, 40)
                    .padding(.top, 2)
                }
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

#Preview {
    LoginView()
}
