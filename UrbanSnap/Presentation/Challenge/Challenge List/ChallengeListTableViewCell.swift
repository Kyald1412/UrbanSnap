//
//  ChallengeListTableViewCell.swift
//  UrbanSnap
//
//  Created by Atikah Aulia on 10/06/21.
//

import UIKit

class ChallengeListTableViewCell: UITableViewCell {

    @IBOutlet weak var lockedView: DesignableView!
    @IBOutlet weak var lockDesc: UILabel!
    @IBOutlet weak var lockIcon: UIImageView!
    @IBOutlet weak var label : UILabel!
    @IBOutlet weak var desc : UILabel!
    @IBOutlet weak var img : UIImageView!
    
    @IBOutlet weak var blurView: UIView!
    
    func setLevelList(with challenges: Challenges){
        label.text = "Level \(challenges.level)"
        desc.text = challenges.short_desc
        img.image = UIImage(named:challenges.icon ?? "")
        lockedView.isHidden = challenges.unlock
        lockIcon.isHidden = challenges.unlock
        lockDesc.isHidden = challenges.unlock
        lockDesc.text = "Complete level \(challenges.level-1) to unlock"
    }
    
    func setBlurView(){
        let blurEffect = UIBlurEffect(style: .dark)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = self.blurView.bounds
        blurredEffectView.alpha = 0.5
        blurredEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        blurredEffectView.layer.cornerRadius = 10
        blurredEffectView.translatesAutoresizingMaskIntoConstraints = false
        self.lockedView.insertSubview(blurredEffectView, at: 1)

    }
    
}

extension UIView {
    func addBlurToView() {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = self.bounds
        blurredEffectView.alpha = 0.7
        blurredEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurredEffectView)
    }
}
