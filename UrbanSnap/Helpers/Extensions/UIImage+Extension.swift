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

    static let badge = UIImage.image(named: "Badge")
    static let onboardingLearn = UIImage.image(named: "Onboarding-Learn")
    static let onboardingPractice = UIImage.image(named: "Onboarding-Practice")
    static let onboardingReflect = UIImage.image(named: "Onboarding-Reflect")
    static let padlock = UIImage.image(named: "Padlock")
    static let ilustrasiLevel1 = UIImage.image(named: "ilustrasi level 1")
    static let ilustrasiLevel2 = UIImage.image(named: "ilustrasi level 2")
    static let ilustrasiLevel3 = UIImage.image(named: "ilustrasi level 3")
    static let placeholder = UIImage.image(named: "placeholder")

    private static func image(named: String) -> UIImage {
        return UIImage(named: named)!
    }
}
