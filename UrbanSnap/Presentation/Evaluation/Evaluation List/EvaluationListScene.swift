//
//  EvaluationSuccessScene.swift
//  UrbanSnap
//
//  Created by Dhiky Aldwiansyah on 07/06/21.
//

import UIKit

class EvaluationListScene: UIViewController{
    
    @IBOutlet weak var levelTableView : UITableView!
    
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var emptyImage: UIImageView!
    @IBOutlet weak var emptyLabel1: UILabel!
    @IBOutlet weak var emptyLabel2: UILabel!
    
    private let galleryList = [ Evaluation(level: "Level 1", gallery: [ Photos(image: UIImage.ilustrasiLevel2)])]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        levelTableView.dataSource = self
        levelTableView.delegate = self
        emptyPage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("viewWillAppear count \(EvaluationDataRepository.shared.getAllEvaluations().count)")
        
    }
    
    func emptyPage(){
        if EvaluationDataRepository.shared.getAllEvaluations().count == 0 {
            emptyView.isHidden = false
        } else {
            emptyView.isHidden = true
        }
    }
    
}

extension EvaluationListScene: UITableViewDelegate{
    
}

extension EvaluationListScene: GalleryListCellDelegate{
    func performSegueFromCell() {
        //        passing data to evaluation detail
        //        openEvaluationDetail()
    }
}

extension EvaluationListScene: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return galleryList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = galleryList[indexPath.row]
        let cell = levelTableView.dequeueReusableCell(withIdentifier: "galleryItem", for: indexPath) as! GalleryListTableViewCell
        cell.displayLevelGallery(with: item)
        cell.delegate = self
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        return cell
    }

    func openEvaluationDetail(evaluationData: EvaluationDetails){
        let evaluationScene = UIStoryboard(name: "EvaluationDetail", bundle: nil).instantiateViewController(withIdentifier: "EvaluationDetailLevel") as! EvaluationDetailLevel
        evaluationScene.evaluationDetailsData = evaluationData
        self.navigationController?.pushViewController(evaluationScene, animated: true)
    }
}

struct Evaluation{
    let level : String
    let gallery : [Photos]
}

struct Photos{
    var image : UIImage
}
