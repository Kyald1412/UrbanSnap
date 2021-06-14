//
//  ReflectionSuccessScene.swift
//  UrbanSnap
//
//  Created by Dhiky Aldwiansyah on 07/06/21.
//

import UIKit

class ReflectionListScene: UIViewController{
    
    @IBOutlet weak var levelTableView : UITableView!
    
    private let galleryList = [ Evaluation(level: "Level 1", gallery: [ Photos(image: UIImage.ilustrasiLevel2)])]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        levelTableView.dataSource = self
        levelTableView.delegate = self
    }
    
}

extension ReflectionListScene: UITableViewDelegate{
    
}

extension ReflectionListScene: GalleryListCellDelegate{
    func performSegueFromCell() {
        openEvaluationDetail()
    }
}

extension ReflectionListScene: UITableViewDataSource{
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func openEvaluationDetail(){
        let evaluationScene = UIStoryboard(name: "EvaluationDetail", bundle: nil).instantiateViewController(withIdentifier: "EvaluationDetailLevel") as! EvaluationDetailLevel
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
