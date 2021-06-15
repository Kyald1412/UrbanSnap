//
//  GalleryListTableViewCell.swift
//  UrbanSnap
//
//  Created by Atikah Aulia on 10/06/21.
//

import UIKit

protocol GalleryListCellDelegate {
    func performSegueFromCell()
}

class GalleryListTableViewCell: UITableViewCell {

    @IBOutlet weak var galleryCollectionView : UICollectionView!
    @IBOutlet weak var levelLabel : UILabel!
    var photos: [Photos]?
    
    var delegate: GalleryListCellDelegate!
    
    func displayLevelGallery(with eval: Evaluation){
        levelLabel.text = eval.level
        photos = eval.gallery
        
        galleryCollectionView.reloadData()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        galleryCollectionView.delegate = self
        galleryCollectionView.dataSource = self
    }
}

extension GalleryListTableViewCell: UICollectionViewDelegate{
    
}

extension GalleryListTableViewCell: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("CEKCEK")
        return photos?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = galleryCollectionView.dequeueReusableCell(withReuseIdentifier: "galleryItem", for: indexPath) as! PhotosCollectionViewCell
       
        if let item = photos {
            cell.displayPhotosTaken(with: item[indexPath.row])
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.delegate != nil {
            self.delegate.performSegueFromCell()
        }
    }
    
    
    
}
