//
//  UIView+Extension.swift
//  Diabestie
//
//  Created by Dhiky Aldwiansyah on 01/04/21.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showSelectionAlertWithCompletion(title: String, msg: String, confirmMsg: String, cancelMsg: String, completionBlock: @escaping (Bool) -> Void) {
       
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: confirmMsg, style: .default, handler: { action in
            
            completionBlock(true)
        })
        
        let cancelButton = UIAlertAction(title: cancelMsg, style: .default, handler: { action in
            
            completionBlock(false)
            
        })
        
        alert.addAction(cancelButton)
        alert.addAction(okButton)

        self.present(alert, animated: true, completion: nil)
    }
}