//
//  RecipeFetcher.swift
//  RecipeSearch
//
//  Created by chris on 2/2/2025.
//

//搜索功能实现的类文件。其实例用于处理发送的请求，并获取node.js返回的数据库数据结果

import Foundation

class RecipeFetcher: ObservableObject {
    @Published var recipes: [Recipe] = []
    
    
    //此方法为get方法，只是用来获取默认的recommended recipes，将结果赋值给RecipeList的Recipe数组实例，并在SearchView内迭代展示RecipeList实例中的所有Recipe实例
    func fetchRecipes() {
        guard let url = URL(string: "http://localhost:3000/api/recipes") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            //test code, fetch predefined json data from node.js
//            if let data = data {
//                do {
//                    let decodedData = try JSONDecoder().decode([Recipe].self, from: data)
//                    DispatchQueue.main.async {
//                        self.recipes = decodedData
//                        print(self.recipes)
//                    }
//                } catch {
//                    print("JSON解析错误:", error)
//                }
//            }
            
            //test code, fetch all recommended recipes from mysql database via node.js
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                do {
                    self.recipes = try JSONDecoder().decode([Recipe].self, from: data)
                    print("✅ 搜索成功，收到 \(self.recipes.count) 条结果")
                    print(self.recipes)
                } catch {
                    print("❌ JSON 解析失败:", error)
                }
            }
        }.resume()
    }
    
    
    //此方法为post方法，用来在SearchBar内触发关键字搜索，并获取node.js返回的数据库查询数据，在SearchResultView内更新数据
    func searchRecipes(searchQuery: String) {
        print("🔍 触发搜索请求，搜索关键词: \(searchQuery)")
        
        guard let url = URL(string: "http://localhost:3000/api/search") else {
            print("❌ URL 不合法")
            return
        }
                
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body = ["query": searchQuery]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("❌ 请求错误:", error.localizedDescription)
                return
            }
            
            guard let data = data else {
                print("❌ 没有收到数据")
                return
            }
            
            do {
                let decodedRecipes = try JSONDecoder().decode([Recipe].self, from: data)
                DispatchQueue.main.async {
                    self.recipes = decodedRecipes
                    print("✅ 搜索成功，收到 \(decodedRecipes.count) 条结果")
                    print(decodedRecipes)
                }
            } catch {
                print("解码错误: \(error)")
            }
        }.resume()
    }
}
