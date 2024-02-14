//
//  MealsCollectionViewController.swift
//  RS_Assignment
//
//  Created by Keerthaprasanth Ravikumar on 11/02/24.
//

import UIKit

class MealCollectionViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet weak var mealCollectionView: UICollectionView!
    var viewModel: MealCollectionViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupOnLoad()
    }

    // MARK: - Setup View Did Load

    private func setupOnLoad() {
        self.title = viewModel.selectedMealName ?? ""
        configureCollectionView()
        loadData()
    }
}

// MARK: - Private Extension

private extension MealCollectionViewController {

    // MARK: - CollectionView Configuration

    func configureCollectionView() {
        mealCollectionView.delegate = self
        mealCollectionView.dataSource = self
    }

    // MARK: - API Data Loading

    func loadData() {
        LoadingIndicatorManager.shared.showLoadingIndicator(on: self.view)
        viewModel.getMealCollection(completion: { [weak self] errorMessage in
            guard let self = self else { return }
            DispatchQueue.main.async {
                LoadingIndicatorManager.shared.hideLoadingIndicator()
                if let error = errorMessage {
                    self.showErrorAlert(message: error)
                } else {
                    self.mealCollectionView.reloadData()
                }
            }
        })
    }
}

// MARK: - Collection View DataSource

extension MealCollectionViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getMealListCount()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MealCollectionViewCell", for: indexPath) as? MealCollectionViewCell else {
            // Handle the error, log, or return a placeholder cell
            print("Error: Unable to dequeue MealCollectionViewCell")
            return UICollectionViewCell()
        }

        let value = viewModel.getMealItems()
        cell.loadCollectionData(model: value[indexPath.row])

        return cell
    }
}

// MARK: - Collection View Flow Layout

extension MealCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let yourWidth = collectionView.bounds.width/3.0
        let yourHeight = yourWidth

        return CGSize(width: yourWidth, height: yourHeight)
    }
}

// MARK: - Static Method

extension MealCollectionViewController {
    static func initViewController() -> MealCollectionViewController? {
        let storyboard = UIStoryboard(name: StoryboardName.main.rawValue, bundle: nil)
        if let viewController = storyboard.instantiateViewController(withIdentifier: MealCollectionViewController().className) as? MealCollectionViewController {
            return viewController
        }
        return nil
    }
}
