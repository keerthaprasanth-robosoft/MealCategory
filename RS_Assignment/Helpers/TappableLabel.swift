//
//  ExpandLabel.swift
//  RS_Assignment
//
//  Created by Keerthaprasanth Ravikumar on 12/02/24.
//

import UIKit
import Foundation

// MARK: - TappableLabel

class TappableLabel: UILabel {

    func getExpanCollapseAttributedText(isExpanded: Bool, fullText: String) -> NSAttributedString {
        if isExpanded {
            let attributedString = NSMutableAttributedString(string: fullText)
            let readLessString = NSAttributedString(string: NSLocalizedString(Constants.hideText, comment: "Hide button"), attributes: [NSAttributedString.Key.foregroundColor: UIColor.blue])
            attributedString.append(readLessString)
            return attributedString
        } else {
            let truncatedText = String(fullText.prefix(60))
            let attributedString = NSMutableAttributedString(string: truncatedText)
            let readMoreString = NSAttributedString(string: NSLocalizedString(Constants.viewMoreText, comment: "View More Button"), attributes: [NSAttributedString.Key.foregroundColor: UIColor.blue])
            attributedString.append(readMoreString)
            return attributedString
        }
    }
}

// MARK: - TapGesture

extension UITapGestureRecognizer {

    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)

        // Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)

        // Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize

        // Find the tapped character location and compare it to the specified range
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        let textContainerOffset = CGPoint(
            x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x,
            y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y
        )
        let locationOfTouchInTextContainer = CGPoint(
            x: locationOfTouchInLabel.x - textContainerOffset.x,
            y: locationOfTouchInLabel.y - textContainerOffset.y
        )
        let indexOfCharacter = layoutManager.characterIndex(
            for: locationOfTouchInTextContainer,
            in: textContainer,
            fractionOfDistanceBetweenInsertionPoints: nil
        )

        return NSLocationInRange(indexOfCharacter, targetRange)
    }

}
