//
//  MealCollectionViewModel.swift
//  RS_Assignment
//
//  Created by Keerthaprasanth Ravikumar on 11/02/24.
//

import Foundation

class MealCollectionViewModel {

    // MARK: - Properties

    var selectedMealName: String?
    var mealData: MealModel?
    var apiHandler: APIHandler = APIHandler()

    init(selectedMealName: String ) {
        self.selectedMealName = selectedMealName
    }

    // MARK: - Sub MealCategory Api Call

    func getMealCollection(completion: @escaping (String?) -> Void) {
        let url = APIConfig.baseURL + APIConfig.versionPath + APIConfig.ContentPaths.subCategory + (selectedMealName ?? "")

        apiHandler.fetchData(urlString: url) { [weak self] (mealData: MealModel?, error) in
            guard let self = self else {
                completion("Self was deallocated.")
                return
            }

            if let items = mealData {
                self.mealData = items
                completion(nil)
            } else if let error = error {
                completion(error.asAFError?.localizedDescription)
            } else {
                completion("Unknown error.")
            }
        }
    }

    // MARK: - Get Sub MealCategory Items Count

    func getMealListCount() -> Int {
        return mealData?.meal?.count ?? 0
    }

    // MARK: - Get Sub MealCategory Items

    func getMealItems() -> [Meal] {
        return mealData?.meal ?? []
    }
}
