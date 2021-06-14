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

extension ReflectionListScene: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 200
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let item = galleryList[indexPath.row]
            let cell = levelTableView.dequeueReusableCell(withIdentifier: "galleryItem", for: indexPath) as! GalleryListTableViewCell
//            cell.setLevelList(with: item)
            cell.layer.cornerRadius = 10
            cell.layer.masksToBounds = true
            return cell
    }
}

struct Evaluation{
    let level : String
    let gallery : [Photos]
}

struct Photos{
    let image : UIImage
}
