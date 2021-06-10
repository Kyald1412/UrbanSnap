//
//  ChallengeCameraScene.swift
//  UrbanSnap
//
//  Created by Dhiky Aldwiansyah on 07/06/21.
//

import UIKit

class ChallengeListScene: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return challengeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = challengeList[indexPath.row]
        let cell = challengeTableView.dequeueReusableCell(withIdentifier: "challengeItem", for: indexPath) as! ChallengeListTableViewCell
        cell.setLevelList(with: item)
//        print("CELL \(cell)")
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        return cell
    }
    
    @IBOutlet weak var challengeTableView: UITableView!
    
    private let challengeList = [ Challenge(level: "Level 1", desc: "Learn to shoot still urban objects with two layers", image: UIImage.ilustrasiLevel1), Challenge(level: "Level 2", desc: "Learn to shoot still urban objects with three layers", image: UIImage.ilustrasiLevel2), Challenge(level: "Level 3", desc: "Learn to shoot moving urban objects with two layers", image: UIImage.ilustrasiLevel3)]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        challengeTableView.delegate = self
        challengeTableView.dataSource = self
        // Do any additional setup after loading the view.
    }


}
struct Challenge{
    let level : String
    let desc: String
    let image: UIImage
}
