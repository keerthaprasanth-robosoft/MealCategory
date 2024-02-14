//
//  UIViewController+Alert.swift
//  RS_Assignment
//
//  Created by Keerthaprasanth Ravikumar on 12/02/24.
//

import Foundation
import UIKit

// MARK: - View Controller Extension

extension UIViewController {
    func showErrorAlert(message: String) {
        let alertController = UIAlertController(title: NSLocalizedString(Constants.errorTitle, comment: "error title"), message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: NSLocalizedString(Constants.errorAlertButton, comment: "error button title"), style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

// MARK: - Table View Cell Extension

extension UITableViewCell {
    func calculateNumberOfLines(for label: UILabel) -> Int {
        let text = label.text ?? ""
        let font = label.font
        let rect = CGSize(width: label.bounds.width, height: .greatestFiniteMagnitude)
        let boundingBox = text.boundingRect(with: rect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font!], context: nil)
        let numberOfLines = Int(ceil(boundingBox.height / font!.lineHeight))
        return numberOfLines
    }
}

// MARK: - Circle Image View

extension UIImageView {
    func circleImageview() {
        contentMode = .scaleAspectFit
        layer.cornerRadius = self.frame.width / 2
        clipsToBounds = true
    }
}
