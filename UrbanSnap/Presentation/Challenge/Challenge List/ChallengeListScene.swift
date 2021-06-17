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
        cell.removeBlurEffect()
        cell.setBlurView()
        cell.selectionStyle = .none
        
        return cell
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        challengeList = ChallengeDataRepository.shared.getAllChallenges()
        challengeTableView.reloadData()
    }
    
    @IBOutlet weak var challengeTableView: UITableView!
    
    var challengeList = ChallengeDataRepository.shared.getAllChallenges()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.navigationController?.navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "", style: .plain, target: nil, action: nil)
        
        
       // challengeTableView.separatorStyle = .singleLine
        challengeTableView.showsVerticalScrollIndicator = false
        challengeTableView.delegate = self
        challengeTableView.dataSource = self
        
        //making table view looks good

    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("DID SELECT")
        if challengeList[indexPath.row].unlock {
            openChallengeDetail(challenge: challengeList[indexPath.row])
        }
    }
    
    func openChallengeDetail(challenge: Challenges){
        let challengeScene = UIStoryboard(name: "ChallengeDetail", bundle: nil).instantiateViewController(withIdentifier: "ChallengeDetailScene") as! ChallengeDetailScene
        challengeScene.challengeDetailList = challenge
        self.navigationController?.pushViewController(challengeScene, animated: true)
    }
    

}
