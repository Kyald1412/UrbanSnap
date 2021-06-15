//
//  ChallengeListTableViewCell.swift
//  UrbanSnap
//
//  Created by Atikah Aulia on 10/06/21.
//

import UIKit

class ChallengeListTableViewCell: UITableViewCell {

    @IBOutlet weak var label : UILabel!
    @IBOutlet weak var desc : UILabel!
    @IBOutlet weak var img : UIImageView!
    
    func setLevelList(with challenges: Challenges){
        label.text = "Level \(challenges.level)"
        desc.text = challenges.short_desc
        img.image = UIImage(named:challenges.icon ?? "")
    }
    
    
}
