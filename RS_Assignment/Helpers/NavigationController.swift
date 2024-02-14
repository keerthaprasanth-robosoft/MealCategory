//
//  NavigationController.swift
//  RS_Assignment
//
//  Created by Keerthaprasanth Ravikumar on 14/02/24.
//

import Foundation
import UIKit

// MARK: - NavigationBar Appearance

class NavigationBarAppearanceManager {
    static func setupAppearance() {
        if #available(iOS 15, *) {
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.configureWithOpaqueBackground()
            navigationBarAppearance.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.white
            ]
            navigationBarAppearance.backgroundColor = UIColor.black
            UINavigationBar.appearance().standardAppearance = navigationBarAppearance
            UINavigationBar.appearance().compactAppearance = navigationBarAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        }
    }
}
