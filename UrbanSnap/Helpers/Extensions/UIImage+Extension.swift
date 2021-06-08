//
//
//  UIImage+Extension.swift
//  Diabestie
//
//  Created by Diabestie Team.
//  swiftlint:disable all

import UIKit

// MARK: - Images Asset

extension UIImage {

    static let placeholder = UIImage.image(named: "placeholder")

    private static func image(named: String) -> UIImage {
        return UIImage(named: named)!
    }
}
