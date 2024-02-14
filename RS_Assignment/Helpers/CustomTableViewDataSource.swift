//
//  CustomTableViewDataSource.swift
//  RS_Assignment
//
//  Created by Keerthaprasanth Ravikumar on 14/02/24.
//

import Foundation
import UIKit

class GenericTableDataSource<T, Cell: UITableViewCell>: NSObject, UITableViewDataSource {
    var items: [T]
    var configureCell: (T, Cell) -> Void
    var cellIdentifier: String

    init(items: [T], cellIdentifier: String, configureCell: @escaping (T, Cell) -> Void) {
        self.items = items
        self.cellIdentifier = cellIdentifier
        self.configureCell = configureCell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        if let typedCell = cell as? Cell {
            if indexPath.row < items.count {
                let item = items[indexPath.row]
                configureCell(item, typedCell)
                return typedCell
            } else {
                fatalError("Index out of bounds: indexPath.row \(indexPath.row) for items array of count \(items.count)")
            }
        } else {
            fatalError("Failed to cast cell to expected type: \(Cell.self)")
        }
    }
}
