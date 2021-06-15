//
//  CommonFunction.swift
//  UrbanSnap
//
//  Created by Dhiky Aldwiansyah on 09/06/21.
//

import Foundation
import UIKit
import AVFoundation

class CommonFunction {
    static let shared = CommonFunction()
    
    func flash(layer: CALayer, numberOfFlashes: Float) {
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 0.2
        flash.fromValue = 1
        flash.toValue = 0.1
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        flash.autoreverses = true
        flash.repeatCount = numberOfFlashes
        layer.add(flash, forKey: nil)
    }
    
    func playSystemSound(id: UInt32){
        AudioServicesPlaySystemSound(id)
    }
    
}
