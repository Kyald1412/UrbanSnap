//
//  GalleryListTableViewCell.swift
//  UrbanSnap
//
//  Created by Atikah Aulia on 10/06/21.
//

import UIKit

class GalleryListTableViewCell: UITableViewCell {

    @IBOutlet weak var galleryCollectionView : UICollectionView!
    @IBOutlet weak var levelLabel : UILabel!
    
    func displayLevelGallery(with eval: Evaluation){
        levelLabel.text = eval.level
//        galleryCollectionView.
    }
}
