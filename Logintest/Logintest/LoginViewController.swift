import SwiftUI

struct FoodChoiceLoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var showingAlert = false
    @State private var alertMessage = ""
    @State private var isLoading = false
    
    var body: some View {
        VStack {
            TextField("用户名", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            SecureField("密码", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button(action: {
                isLoading = true
                login()
            }) {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                } else {
                    Text("登录")
                }
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(5)
            .disabled(isLoading)
            
            Button(action: {
                print("跳转到注册页面")
            }) {
                Text("注册")
            }
            .padding()
            
            Button(action: {
                print("密码重置流程")
            }) {
                Text("忘记密码")
            }
            .padding()
        }
        .padding()
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("提示"), message: Text(alertMessage), dismissButton: .default(Text("确定")))
        }
    }
    
    func login() {
        guard let url = URL(string: "http://localhost:3000/api/login") else {
            showAlert("无效的 URL")
            return
        }
        
        print("开始登录请求...")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let parameters: [String: Any] = [
            "username": username,
            "password": password
        ]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: [])
            request.httpBody = jsonData
            print("请求参数:", String(data: jsonData, encoding: .utf8) ?? "")
        } catch {
            print("JSON 序列化错误:", error)
            showAlert("请求错误")
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                isLoading = false
                
                if let error = error {
                    print("网络错误:", error)
                    showAlert("网络错误: \(error.localizedDescription)")
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse {
                    print("HTTP 状态码:", httpResponse.statusCode)
                }
                
                guard let data = data else {
                    print("无数据返回")
                    showAlert("无数据返回")
                    return
                }
                
                print("收到响应数据:", String(data: data, encoding: .utf8) ?? "")
                
                do {
                    if let response = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                       let message = response["message"] as? String {
                        print("解析的消息:", message)
                        if message == "登录成功" {
                            showAlert("登录成功")
                        } else {
                            showAlert(message)
                        }
                    }
                } catch {
                    print("JSON 解析错误:", error)
                    showAlert("数据解析错误")
                }
            }
        }.resume()
    }
    
    private func showAlert(_ message: String) {
        alertMessage = message
        showingAlert = true
    }
}

struct FoodChoiceLoginView_Previews: PreviewProvider {
    static var previews: some View {
        FoodChoiceLoginView()
    }
}
