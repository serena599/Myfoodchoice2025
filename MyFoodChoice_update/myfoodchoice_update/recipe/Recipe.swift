//
//  Recipe.swift
//  RecipeSearch
//
//  Created by chris on 13/12/2024.
//

// Recipe object file. Will be detailed when data format has been confirmed.

import Foundation
import SwiftUI

//class Recipe {
//    let id: String
//    let title: String
//    let image: Image
//    let url: String
//    let ingredients: [String: Int]
//    
//    init(id: String, title: String, image: Image, url: String, ingredients: [String: Int]) {
//        self.id = id
//        self.title = title
//        self.image = image
//        self.url = url
//        self.ingredients = ingredients
//    }
//    
//    // for test & ui presentation
//    init(title: String, image: Image) {
//        self.id = ""
//        self.title = title
//        self.image = image
//        self.url = ""
//        self.ingredients = [:]
//    }
//}

struct Recipe {
    var title: String
    var image: Image
    var ingredients: [String: Int] = [:]
    var isCollected: Bool = false
}
