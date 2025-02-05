//
//  Recipe.swift
//  RecipeSearch
//
//  Created by chris on 13/12/2024.
//

// Recipe object file. Will be detailed when data format has been confirmed.

import Foundation
import SwiftUI


//根据Alex和Jiabao提供的数据结构文档，重新定义Recipe的数据格式和成员属性
struct Recipe: Decodable {
    var recipe_ID: Int
    var recipe_name: String
    var instructions: String = ""
    var image_URL: String = ""
    var traffic_lights: [String: String] = [:]
    var food_type: String = ""
    var is_recommend: Bool = false
}
