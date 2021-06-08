//
//  UIColor+Extension.swift
//  Diabestie
//
//  Created by Diabestie Team.
//  swiftlint:disable all

import UIKit

// MARK: - Colors Asset

extension UIColor {

    static let black = UIColor.color(named: "black")
    static let white = UIColor.color(named: "white")

    private static func color(named: String) -> UIColor {
        return UIColor(named: named)!
    }

}

