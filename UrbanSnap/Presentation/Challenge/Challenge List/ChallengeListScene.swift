//
//  ChallengeCameraScene.swift
//  UrbanSnap
//
//  Created by Dhiky Aldwiansyah on 07/06/21.
//

import UIKit

class ChallengeListScene: UIViewController {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return challengeList.count
//    }
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let item = challengeList[indexPath.row]
//        let cell = challengeTableView.dequeueReusableCell(withIdentifier: "challengeItem", for: indexPath) as! ChallengeListTableViewCell
//        cell.update(with: item)
//        print("CELL \(cell)")
//        return cell
//    }
    
    @IBOutlet weak var challengeTableView: UITableView!
    
    private let challengeList = [ Challenge(level: "Level 1", desc: "Belajar fotografi bersama kami", image: "yes"), Challenge(level: "Level 2", desc: "Belajar fotografi bersama kami", image: "yes"), Challenge(level: "Level 3", desc: "Belajar fotografi bersama kami", image: "yes")]
    override func viewDidLoad() {
        
//        challengeTableView.register(UITableViewCell.self, forCellReuseIdentifier: "challengeItem")
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    struct Challenge{
        let level : String
        let desc: String
        let image: String
    }

}
