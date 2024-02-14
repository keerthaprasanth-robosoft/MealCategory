//
//  MealCategoryViewModel.swift
//  RS_Assignment
//
//  Created by Keerthaprasanth Ravikumar on 11/02/24.
//

import Foundation

class MealCategoryViewModel {

    // MARK: - Properties

    var mealItems: MealCategoryModel?
    var apiHandler: APIHandler = APIHandler()

    // MARK: - MealCategory List Api

    func getMealCategory(completion: @escaping (String?) -> Void) {
        let url = APIConfig.baseURL + APIConfig.versionPath + APIConfig.ContentPaths.category

        apiHandler.fetchData(urlString: url) { [weak self] (mealCategoryData: MealCategoryModel?, error) in
            guard let self = self else {
                completion("Self was deallocated.")
                return
            }

            if let items = mealCategoryData {
                self.mealItems = items
                completion(nil)
            } else if let error = error {
                completion(error.asAFError?.localizedDescription)
            } else {
                completion("Unknown error.")
            }
        }
    }

    // MARK: - MealCategory List Count

    func getMealItemCount() -> Int {
        return mealItems?.category?.count ?? 0
    }

    // MARK: - Get MealCategory List

    func getMealCategoryList() -> [MealCategory] {
        return mealItems?.category ?? []
    }

    // MARK: - Cell Expand/Collapse

    func toggleExpandCell(index: Int) {
        mealItems?.category?[index].isExpanded.toggle()
    }

    // MARK: - Get Item at Index
    func getItem(at index: Int) -> MealCategory? {
        guard index < getMealCategoryList().count else {
            return nil
        }
        return mealItems?.category?[index]
    }
}
