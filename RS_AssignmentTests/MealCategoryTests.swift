//
//  MealCategoryTests.swift
//  RS_AssignmentTests
//
//  Created by Keerthaprasanth Ravikumar on 11/02/24.
//

import XCTest
@testable import RS_Assignment

class MealCategoryViewModelTests: XCTestCase {
    var viewModel: MealCategoryViewModel!
    let mockCategory = [MealCategory(identifier: "1", name: "Category1", imagePath: "thumb1", description: "Description1", isExpanded: false)]

    override func setUp() {
        super.setUp()
        viewModel = MealCategoryViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testFetchMealCategory() {
        let expectation = XCTestExpectation(description: "Fetch meal Category")

        viewModel.getMealCategory {_ in
            XCTAssertNotNil(self.viewModel.mealItems, "Meal Category should not be nil after fetching")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5.0)
    }

    func testMealItemCount() {
        viewModel.mealItems = MealCategoryModel(category: mockCategory)

        XCTAssertEqual(viewModel.getMealItemCount(), 1, "Incorrect meal item count")
    }

    func testMealCategoryList() {
        let mockCategory = MealCategory(identifier: "1", name: "Category1", imagePath: "thumb1", description: "Description1", isExpanded: false)
        viewModel.mealItems?.category = [mockCategory]

        guard let categoryList = viewModel?.getMealCategoryList() else {
            XCTFail("Failed to get meal Category list")
            return
        }

        XCTAssertEqual(categoryList.count, 0, "Incorrect meal Category list count")
        XCTAssertFalse(categoryList.contains { $0.identifier == mockCategory.identifier }, "Incorrect meal Category list elements")
    }

    func testToggleExpandCell() {
        viewModel.mealItems = MealCategoryModel(category: mockCategory)

        viewModel.toggleExpandCell(index: 0)
        XCTAssertTrue(viewModel.mealItems?.category?[0].isExpanded ?? false, "Failed to toggle cell expansion state")
    }
}
