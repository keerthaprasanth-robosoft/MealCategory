//
//  APIHandlerMock.swift
//  RS_AssignmentTests
//
//  Created by Keerthaprasanth Ravikumar on 12/02/24.
//

import XCTest
@testable import RS_Assignment

class APIHandlerMock: APIHandler {
    var success: Bool
    var dummyItems: MealModel?
    var error: Error?

    init(success: Bool, dummyItems: MealModel? = nil, error: Error? = nil) {
        self.success = success
        self.dummyItems = dummyItems
        self.error = error
    }

    func fetchData(urlString: String, completion: @escaping (MealModel?, Error?) -> Void) {
        if success {
            completion(dummyItems, nil)
        } else {
            completion(nil, error)
        }
    }
}
