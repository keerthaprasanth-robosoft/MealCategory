//
//  ViewController.swift
//  RS_Assignment
//
//  Created by Keerthaprasanth Ravikumar on 11/02/24.
//

import UIKit

class MealListViewController: UIViewController {

    var dataSource: GenericTableDataSource<MealCategory, MealItemTableViewCell>!

    // MARK: - Outlets

    @IBOutlet weak var mealListTableview: UITableView!

    let viewModel = MealCategoryViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupOnLoad()
    }

    // MARK: - Setup View Did Load

    private func setupOnLoad() {
        self.title = NSLocalizedString(Constants.navigationTitle, comment: "Name of the App")
        configureTableView()
        loadData()
    }
}

// MARK: - Private Extension

private extension MealListViewController {

    // MARK: - Configure Table View DataSource

    func configureTableView() {
        dataSource = GenericTableDataSource(items: viewModel.getMealCategoryList(), cellIdentifier: MealItemTableViewCell().className) { (item, cell) in
            cell.loadCellData(model: item)
            cell.delegate = self
                }
        mealListTableview.dataSource = dataSource
        mealListTableview.register(UINib(nibName: MealItemTableViewCell().className, bundle: nil), forCellReuseIdentifier: MealItemTableViewCell().className)
    }

    // MARK: - Setup Api Data

    func loadData() {
        LoadingIndicatorManager.shared.showLoadingIndicator(on: self.view)
        viewModel.getMealCategory { [weak self] errorMessage in
            guard let self = self else { return }
            DispatchQueue.main.async {
                LoadingIndicatorManager.shared.hideLoadingIndicator()
                if let error = errorMessage {
                    self.showErrorAlert(message: error)
                } else {
                    self.dataSource.items = self.viewModel.getMealCategoryList()
                    self.mealListTableview.reloadData()
                }
            }
        }
    }
}

// MARK: - TableView Delegate

 extension MealListViewController: UITableViewDelegate {

     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         self.pushViewController(index: indexPath)
     }
 }

// MARK: - MealTableViewDelegate

extension MealListViewController: MealTableViewDelegate {

    func didSelectItem(in cell: MealItemTableViewCell) {
        if let indexPath = mealListTableview.indexPath(for: cell) {
            self.pushViewController(index: indexPath)
        }
    }

    func didTapButton(in cell: MealItemTableViewCell) {
        if let indexPath = mealListTableview.indexPath(for: cell) {
            mealListTableview.deselectRow(at: indexPath, animated: true)
            viewModel.toggleExpandCell(index: indexPath.row)
            mealListTableview.beginUpdates()
            self.dataSource.items = self.viewModel.getMealCategoryList()
            mealListTableview.reloadRows(at: [indexPath], with: .automatic)
            mealListTableview.endUpdates()
        }
    }

    func pushViewController(index: IndexPath) {
        if let mealCollectionViewController =  MealCollectionViewController.initViewController() {
            let viewmodel = MealCollectionViewModel(selectedMealName: viewModel.getMealCategoryList()[index.row].name ?? "")
            mealCollectionViewController.viewModel = viewmodel
            navigationController?.pushViewController(mealCollectionViewController, animated: true)
        }
    }
}

// MARK: - Static Method

extension MealListViewController {
    static func initViewController() -> MealListViewController? {
        let storyboard = UIStoryboard(name: StoryboardName.main.rawValue, bundle: nil)
        if let viewController = storyboard.instantiateViewController(withIdentifier: MealListViewController().className) as? MealListViewController {
            return viewController
        }
        return nil
    }
}
