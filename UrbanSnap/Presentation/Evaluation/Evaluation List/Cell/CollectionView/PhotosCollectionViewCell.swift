//
//  PhotosCollectionViewCell.swift
//  UrbanSnap
//
//  Created by Atikah Aulia on 11/06/21.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var photo : UIImageView!
    
    func displayPhotosTaken(with photos: EvaluationDetails){
        photo.image = UIImage(data: photos.raw_image ?? Data())
    }
}
