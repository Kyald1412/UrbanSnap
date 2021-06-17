//
//  GalleryListTableViewCell.swift
//  UrbanSnap
//
//  Created by Atikah Aulia on 10/06/21.
//

import UIKit

protocol GalleryListCellDelegate {
    func performSegueFromCell(evaluationData: EvaluationDetails)
}

class GalleryListTableViewCell: UITableViewCell {

    @IBOutlet weak var galleryCollectionView : UICollectionView!
    @IBOutlet weak var levelLabel : UILabel!
    var evaluationDetails: [EvaluationDetails]?
    
    var delegate: GalleryListCellDelegate!
    
    func displayLevelGallery(with eval: Evaluations){
        levelLabel.text = "Level \(eval.level)"
        
        if let objectsData = eval.evaluationDetail?.allObjects as? [EvaluationDetails] {
            evaluationDetails = objectsData
        }
        
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
        return evaluationDetails?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = galleryCollectionView.dequeueReusableCell(withReuseIdentifier: "galleryItem", for: indexPath) as! PhotosCollectionViewCell
       
        if let item = evaluationDetails {
            cell.displayPhotosTaken(with: item[indexPath.row])
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.delegate != nil {
            if let item = evaluationDetails {
                self.delegate.performSegueFromCell(evaluationData: item[indexPath.row])
            }
        }
    }
    
    
    
}
