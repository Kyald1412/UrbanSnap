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

    static let assetSlider1 = UIImage.image(named: "Asset slider 1")
    static let assetSlider2 = UIImage.image(named: "Asset slider 2")
    static let assetSlider3 = UIImage.image(named: "Asset slider 3")
    static let assetSlider4 = UIImage.image(named: "Asset slider 4")
    static let assetSlider5 = UIImage.image(named: "Asset slider 5")
    static let assetSlider6 = UIImage.image(named: "Asset slider 6")
    static let assetSlider7 = UIImage.image(named: "Asset slider 7")
    static let assetSlider8 = UIImage.image(named: "Asset slider 8")
    static let assetSlider9 = UIImage.image(named: "Asset slider 9")
    static let badge = UIImage.image(named: "Badge")
    static let onboardingEvaluate = UIImage.image(named: "Onboarding-Evaluate")
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

extension UIImage {
    func fixOrientation() -> UIImage? {
        if self.imageOrientation == UIImage.Orientation.up {
            return self
        }

        UIGraphicsBeginImageContext(self.size)
        self.draw(in: CGRect(origin: .zero, size: self.size))
        let normalizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return normalizedImage
    }
}
