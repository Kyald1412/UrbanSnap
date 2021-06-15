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
    
    func setLevelList(with challenge: Challenge){
        label.text = challenge.level
        desc.text = challenge.desc
        img.image = challenge.image
    }
}
