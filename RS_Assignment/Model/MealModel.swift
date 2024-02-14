//
//  MealModel.swift
//  RS_Assignment
//
//  Created by Keerthaprasanth Ravikumar on 11/02/24.
//

import Foundation

struct MealModel: Codable {
    let meal: [Meal]?

    enum CodingKeys: String, CodingKey {
        case meal = "meals"
    }
}

struct Meal: Codable {
    let name: String?
    let imagePath: String?
    let identifier: String?

    enum CodingKeys: String, CodingKey {
        case identifier = "idMeal"
        case name = "strMeal"
        case imagePath = "strMealThumb"
    }
}
