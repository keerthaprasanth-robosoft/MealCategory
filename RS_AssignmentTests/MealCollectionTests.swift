//
//  MealCollectionTests.swift
//  RS_AssignmentTests
//
//  Created by Keerthaprasanth Ravikumar on 11/02/24.
//

import XCTest
@testable import RS_Assignment

class MealCollectionViewModelTests: XCTestCase {

    var mealCollectionViewModel: MealCollectionViewModel!
    let someDummyMealsModel: MealModel = MealModel(meal: [Meal.init(name: "Rice1", imagePath: "image1", identifier: "1")])
    let someError: Error = NSError(domain: "com.example", code: 123, userInfo: [NSLocalizedDescriptionKey: "This is a dummy error"])
    override func setUp() {
        super.setUp()
        mealCollectionViewModel = MealCollectionViewModel(selectedMealName: "Item")
    }

    override func tearDown() {
        mealCollectionViewModel = nil
        super.tearDown()
    }

    func testGetMealsListCountWithNilData() {
        XCTAssertEqual(mealCollectionViewModel.getMealListCount(), 0)
    }

    func testGetMealsItemsWithNilData() {
        XCTAssertTrue(mealCollectionViewModel.getMealItems().isEmpty)
    }

    func testGetMealCollectionSuccess() {
        let apiHandlerMock = APIHandlerMock(success: true, dummyItems: someDummyMealsModel)
        mealCollectionViewModel.apiHandler = apiHandlerMock

        mealCollectionViewModel.getMealCollection {_ in
            XCTAssertEqual(self.mealCollectionViewModel.getMealListCount(), self.someDummyMealsModel.meal?.count)
        }
    }

    func testGetMealCollectionFailure() {
        let apiHandlerMock = APIHandlerMock(success: false, error: someError)
        mealCollectionViewModel.apiHandler = apiHandlerMock

        mealCollectionViewModel.getMealCollection {_ in
            XCTAssertEqual(self.mealCollectionViewModel.getMealListCount(), 0)
            XCTAssertTrue(self.mealCollectionViewModel.getMealItems().isEmpty)
        }
    }
}
