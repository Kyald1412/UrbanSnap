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
        
        for controllers in viewControllers {
            print("CONTROLLER \(controllers)")
            if controllers is ChallengeCameraView {
                self.viewControllers.removeLast()
            }
        }
        
    }
    
}
