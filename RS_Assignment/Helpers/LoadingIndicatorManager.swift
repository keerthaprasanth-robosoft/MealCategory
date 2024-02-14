//
//  LoadingIndicatorManager.swift
//  RS_Assignment
//
//  Created by Keerthaprasanth Ravikumar on 12/02/24.
//

import UIKit

// MARK: - LoadingIndicatorManager

class LoadingIndicatorManager {
    static let shared = LoadingIndicatorManager()

    private var loadingIndicator: UIActivityIndicatorView?

    func showLoadingIndicator(on view: UIView) {
        if loadingIndicator == nil {
            loadingIndicator = createLoadingIndicator()
        }

        loadingIndicator?.center = view.center
        view.addSubview(loadingIndicator!)
        loadingIndicator?.startAnimating()
    }

    func hideLoadingIndicator() {
        loadingIndicator?.stopAnimating()
        loadingIndicator?.removeFromSuperview()
    }

    private func createLoadingIndicator() -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = UIColor.gray
        indicator.hidesWhenStopped = true
        return indicator
    }
}
