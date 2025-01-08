import SwiftUI

struct SignUpView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var username = ""
    @State private var email = ""
    @State private var phone = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    
    var body: some View {
        ZStack {
            Color("IconGreen")
                .ignoresSafeArea()
            
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
                    dismiss()
                }) {
                    Text("SIGN UP")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(Color("IconGreen"))
                        .frame(maxWidth: .infinity)
                        .frame(height: 45)
                        .background(Color.white)
                        .cornerRadius(8)
                }
                .padding(.top, 50)
                
                Spacer()
            }
            .padding(.horizontal, 40)
        }
    }
} 

#Preview {
    SignUpView()
}
