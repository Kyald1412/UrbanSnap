//
//  Step3Controller.swift
//  UrbanSnap
//
//  Created by Wilson Adrilia on 14/06/2021.
//

import UIKit

class Step3Controller: UIViewController, UITextViewDelegate {

    @IBOutlet weak var imageStep3: UIImageView!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var descTextView: UITextView!
    @IBOutlet weak var buttonSafe: UIButton!
    
    var evaluationDetailsData: EvaluationDetails?
    var editedImage: UIImage = UIImage.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
 
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)

        
        self.title = "Step 3 of 3"

        self.imageStep3.image = editedImage
        self.descTextView.placeholder = "Write your learning and describe the moment here"
        self.descTextView.delegate = self

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSaveEvaluation(_ sender: Any) {
        
        let myAlert = UIStoryboard(name: "EvaluationSuccessPopup", bundle: nil).instantiateViewController(withIdentifier: "EvaluationSuccessPopup") as! EvaluationSuccessPopup
        myAlert.delegate = self
        myAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        myAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve

        self.tabBarController?.present(myAlert, animated: true, completion: nil)
        
    }
    
    func textViewDidChange(_ textView: UITextView) {
        print("TEXT COUNT \(textView.text.count)")
        if textView.text.count > 0 {
            self.descTextView.placeholder = ""
            buttonSafe.backgroundColor = .black
            buttonSafe.setTitleColor(.white, for: .normal)
            buttonSafe.isEnabled = true
        } else {
            self.descTextView.placeholder = "Write your learning and describe the moment here"
            buttonSafe.backgroundColor = .gray
            buttonSafe.setTitleColor(.white, for: .normal)
            buttonSafe.isEnabled = false
        }
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height/2
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }

}

extension Step3Controller: EvaluationPopupProtocol {
    func onConfirmButton() {
        if let data = evaluationDetailsData {
            EvaluationDataRepository.shared.updateEvaluationDetail(completed: true, desc: descTextView.text, editedImage: editedImage, data: data)
            let nextChallenge = ChallengeDataRepository.shared.getChallengeByLevel(level: Int(data.challenge?.level ?? 0)+1)
            
            if let nextChallenge = nextChallenge {
                ChallengeDataRepository.shared.updateChallenges(unlock: true, data: nextChallenge)
            }
            
        }
        
        self.dismiss(animated: true) {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
}
