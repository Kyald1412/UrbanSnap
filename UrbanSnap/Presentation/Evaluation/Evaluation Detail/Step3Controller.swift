//
//  Step3Controller.swift
//  UrbanSnap
//
//  Created by Wilson Adrilia on 14/06/2021.
//

import UIKit

class Step3Controller: UIViewController {

    @IBOutlet weak var imageStep3: UIImageView!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var descTextView: UITextView!
    @IBOutlet weak var buttonSafe: UIButton!
    
    var evaluationDetailsData: EvaluationDetails?
    var editedImage: UIImage = UIImage.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Step 3 of 3"

        self.imageStep3.image = editedImage
        self.descTextView.placeholder = "Write your learning and describe the moment here"

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSaveEvaluation(_ sender: Any) {
        
        let myAlert = UIStoryboard(name: "EvaluationSuccessPopup", bundle: nil).instantiateViewController(withIdentifier: "EvaluationSuccessPopup") as! EvaluationSuccessPopup
        myAlert.delegate = self
        myAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        myAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve

        self.tabBarController?.present(myAlert, animated: true, completion: nil)
        
    }

}

extension Step3Controller: EvaluationPopupProtocol {
    func onConfirmButton() {
        if let data = evaluationDetailsData {
            EvaluationDataRepository.shared.updateEvaluationDetail(completed: true, desc: descTextView.text, editedImage: editedImage, data: data)
        }
        self.dismiss(animated: true) {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
}
