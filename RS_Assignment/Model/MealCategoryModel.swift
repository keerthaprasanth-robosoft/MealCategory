//
//  MealCategoryModel.swift
//  RS_Assignment
//
//  Created by Keerthaprasanth Ravikumar on 11/02/24.
//

import Foundation
struct MealCategoryModel: Codable {
    var category: [MealCategory]?
    enum CodingKeys: String, CodingKey {
        case category = "categories"
    }
}

struct MealCategory: Codable {
    let identifier: String
    let name: String?
    let imagePath: String?
    let description: String?
    var isExpanded: Bool = false

    enum CodingKeys: String, CodingKey {
        case identifier = "idCategory"
        case name = "strCategory"
        case imagePath = "strCategoryThumb"
        case description = "strCategoryDescription"
    }
}
