//
//  ChallengeNavigationController.swift
//  UrbanSnap
//
//  Created by Dhiky Aldwiansyah on 18/06/21.
//

import UIKit

class ChallengeNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(onDidReceiveData(_:)), name: .didReceiveData, object: nil)
        
        // Do any additional setup after loading the view.
    }
    
    @objc func onDidReceiveData(_ notification: Notification) {
        // Do something now
        
        
        if let tabBar = self.tabBarController as? HomePageScene {
            tabBar.isAnimated = true
            tabBar.selectedIndex = 1
            tabBar.isAnimated = false
        }
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            for controllers in self.viewControllers {
                print("CONTROLLER \(controllers)")
                if controllers is ChallengeCameraScene {
                    self.viewControllers.removeLast()
                }
                if controllers is ChallengeDetailScene {
                    self.viewControllers.removeLast()
                }
            }
        }
   
    }
    
}
