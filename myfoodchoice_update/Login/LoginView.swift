import SwiftUI

struct LoginView: View {
    @State private var username = ""
    @State private var password = ""
    @Binding var isLoggedIn: Bool
    @State private var showMainView = false
    @State private var showSignUp = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("IconGreen")
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Logo
                    Text("MyfoodChoice")
                        .font(.system(size: 43, weight: .bold))
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.2), radius: 2, x: 0, y: 2)
                        .padding(.top, 70)
                        .padding(.bottom, 230)
                    
                    // 输入框和按钮
                    VStack(spacing: 25) {
                        // 用户名输入框
                        HStack {
                            Image(systemName: "person")
                                .foregroundColor(.white)
                                .padding(.leading, 8)
                            TextField("", text: $username)
                                .foregroundColor(.white)
                                .accentColor(.white)
                                .placeholder(when: username.isEmpty) {
                                    Text("USERNAME")
                                        .foregroundColor(.white.opacity(0.7))
                                }
                        }
                        .frame(height: 45)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.white, lineWidth: 1)
                        )
                        .padding(.horizontal, 30)
                        
                        // 密码输入框
                        HStack {
                            Image(systemName: "lock")
                                .foregroundColor(.white)
                                .padding(.leading, 8)
                            SecureField("", text: $password)
                                .foregroundColor(.white)
                                .accentColor(.white)
                                .placeholder(when: password.isEmpty) {
                                    Text("PASSWORD")
                                        .foregroundColor(.white.opacity(0.7))
                                }
                        }
                        .frame(height: 45)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.white, lineWidth: 1)
                        )
                        .padding(.horizontal, 30)
                        
                        // 登录按钮
                        Button(action: {
                            showMainView = true
                        }) {
                            Text("LOGIN")
                                .font(.system(size: 16))
                                .foregroundColor(Color("IconGreen"))
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
                                showSignUp = true
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
                        
                        Spacer()
                    }
                }
            }
            .navigationDestination(isPresented: $showMainView) {
                MainView()
            }
            .navigationDestination(isPresented: $showSignUp) {
                SignUpView()
            }
        }
    }
} 

#Preview {
    LoginView(isLoggedIn: .constant(false))
}
