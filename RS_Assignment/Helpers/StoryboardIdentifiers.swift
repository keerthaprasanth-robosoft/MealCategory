//
//  StoryboardIdentifiers.swift
//  RS_Assignment
//
//  Created by Keerthaprasanth Ravikumar on 14/02/24.
//

import Foundation

enum StoryboardName: String {
    case main = "Main"
}

extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }
}
