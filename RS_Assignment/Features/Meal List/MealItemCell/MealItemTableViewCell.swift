//
//  MealItemTableViewCell.swift
//  RS_Assignment
//
//  Created by Keerthaprasanth Ravikumar on 11/02/24.
//

import Nuke
import UIKit

// MARK: - MealTableViewDelegate Protocol

protocol MealTableViewDelegate: AnyObject {
    func didTapButton(in cell: MealItemTableViewCell)
    func didSelectItem(in cell: MealItemTableViewCell)
}

// MARK: - MealItemTableViewCell Class

class MealItemTableViewCell: UITableViewCell {

    // MARK: Outlets

    @IBOutlet weak var mealImage: UIImageView!
    @IBOutlet weak var mealName: UILabel!
    @IBOutlet weak var mealDescription: TappableLabel!

    // MARK: Properties

    weak var delegate: MealTableViewDelegate?

    // MARK: Initialization

    override func awakeFromNib() {
        super.awakeFromNib()
        mealImage.circleImageview()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    // MARK: Load Cell Data

    func loadCellData(model: MealCategory) {
        // Load image using Nuke
        if let urlString = URL(string: model.imagePath ?? "") {
            Nuke.loadImage(with: urlString, into: mealImage)
        }

        // Set mealName
        mealName.text = model.name ?? ""

        // Configure mealDescription
        mealDescription.lineBreakMode = .byTruncatingTail
        mealDescription.numberOfLines = model.isExpanded ? 0 : 2

        // Create a temporary UILabel to calculate the number of lines
        let uilabel = UILabel()
        uilabel.bounds = mealDescription.bounds
        uilabel.text = model.description ?? ""

        // Calculate the number of lines in the description
        let numberOfLines = calculateNumberOfLines(for: uilabel)

        // Set the attributed text if there are more than 2 lines
        if numberOfLines > 2 {
            mealDescription.attributedText = mealDescription.getExpanCollapseAttributedText(isExpanded: model.isExpanded, fullText: model.description ?? "")
        } else {
            // Set regular text if there are 2 or fewer lines
            mealDescription.text = model.description ?? ""
        }

        // view more TapGestureRecognizer added

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewMoreTapped))
        mealDescription.addGestureRecognizer(tapGesture)
        mealDescription.isUserInteractionEnabled = true

    }

    // MARK: View More/Hide button Action

    @objc private func viewMoreTapped(_ gesture: UITapGestureRecognizer) {
        guard let text = mealDescription.text else { return }
        let textRange = (text as NSString).range(of: NSLocalizedString(Constants.viewMoreText, comment: "View More Button"))
        let hideTextRange = (text as NSString).range(of: NSLocalizedString(Constants.hideText, comment: "Hide button"))
        if gesture.didTapAttributedTextInLabel(label: mealDescription, inRange: textRange) {
            delegate?.didTapButton(in: self)
        } else if gesture.didTapAttributedTextInLabel(label: mealDescription, inRange: hideTextRange) {
            delegate?.didTapButton(in: self)
        } else {
            delegate?.didSelectItem(in: self)
        }
    }

}
