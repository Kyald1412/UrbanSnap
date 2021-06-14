//
//  ChallengeCameraScene.swift
//  UrbanSnap
//
//  Created by Dhiky Aldwiansyah on 07/06/21.
//

import UIKit

class ChallengeListScene: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 172
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return challengeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
  
        let item = challengeList[indexPath.row]
        let cell = challengeTableView.dequeueReusableCell(withIdentifier: "challengeItem", for: indexPath) as! ChallengeListTableViewCell
        cell.setLevelList(with: item)
//        print("CELL \(cell)")
//        cell.layer.cornerRadius = 10
//        cell.layer.masksToBounds = true
//        cell.layer.borderWidth = 0.5
        



        //cell.contentView =

        return cell
    }
    

    
    
    @IBOutlet weak var challengeTableView: UITableView!
    
    private let challengeList = [ Challenge(level: "Level 1", desc: "Learn to shoot still urban objects with two layers", image: UIImage.ilustrasiLevel1), Challenge(level: "Level 2", desc: "Learn to shoot still urban objects with three layers", image: UIImage.ilustrasiLevel2), Challenge(level: "Level 3", desc: "Learn to shoot moving urban objects with two layers", image: UIImage.ilustrasiLevel3)]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
       // challengeTableView.separatorStyle = .singleLine
        challengeTableView.showsVerticalScrollIndicator = false
        challengeTableView.delegate = self
        challengeTableView.dataSource = self
        challengeTableView.allowsSelection = false
        
        
        //making table view looks good

        // Do any additional setup after loading the view.
    }

}
struct Challenge{
    let level : String
    let desc: String
    let image: UIImage
}

//extension UIView{
//    func dropShadow(scale:Bool = true){
//        layer.masksToBounds = false
//        layer.shadowColor = UIColor.blue.cgColor
//        layer.shadowOpacity = 0.23
//        layer.shadowOffset = CGSize.zero
//        layer.shadowRadius = 3
//        layer.rasterizationScale = UIScreen.main.scale
//    }
//}
