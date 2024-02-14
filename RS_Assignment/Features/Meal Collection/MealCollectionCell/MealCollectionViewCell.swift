//
//  MealCollectionViewCell.swift
//  RS_Assignment
//
//  Created by Keerthaprasanth Ravikumar on 11/02/24.
//

import UIKit
import Nuke

class MealCollectionViewCell: UICollectionViewCell {

    // MARK: Outlets

    @IBOutlet weak var mealImage: UIImageView!
    @IBOutlet weak var mealName: UILabel!

    // MARK: Initialization

    override func awakeFromNib() {
        super.awakeFromNib()
        mealImage.circleImageview()
    }

    // MARK: Load Cell Data

    func loadCollectionData(model: Meal) {
        if let urlString = URL(string: model.imagePath ?? "") {
            Nuke.loadImage(with: urlString, into: mealImage)
        }
        mealName.text = model.name ?? ""
    }
}
