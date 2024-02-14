//
//  ApiConfig.swift
//  RS_Assignment
//
//  Created by Keerthaprasanth Ravikumar on 14/02/24.
//

import Foundation

enum Environment {
    case development
    case stage
    case production
}

struct APIConfig {

    static var environment: Environment = .development

    static var baseURL: String {
        switch environment {
        case .development:
            return "https://www.themealdb.com"
        case .stage:
            return "https://stage.themealdb.com"
        case .production:
            return "https://api.themealdb.com"
        }
    }

    static let versionPath = "/api/json/v1/1"

    struct ContentPaths {
        static let category = "/categories.php"
        static let subCategory = "/filter.php?c="
    }
}
