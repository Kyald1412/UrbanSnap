//
//  ChallengeNavigationController.swift
//  UrbanSnap
//
//  Created by Dhiky Aldwiansyah on 18/06/21.
//

import UIKit

class EvaluationNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(onDidReceiveData(_:)), name: .didReceiveDataEvaluation, object: nil)
        
        // Do any additional setup after loading the view.
    }
    
    @objc func onDidReceiveData(_ notification: Notification) {
        // Do something now
        
        if let tabBar = self.tabBarController as? HomePageScene {
            tabBar.isAnimated = true
            tabBar.selectedIndex = 0
            tabBar.isAnimated = false
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            
            self.viewControllers.removeAll(where: { !($0 is EvaluationListScene) })
        }
   
    }
    
}
