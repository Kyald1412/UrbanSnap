//
//  EvaluationDetailLevel.swift
//  UrbanSnap
//
//  Created by Wilson Adrilia on 14/06/2021.
//

import UIKit

class EvaluationDetailLevel: UIViewController {

    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var descTextView: UILabel!
    @IBOutlet weak var emptyLabel1: UILabel!
    @IBOutlet weak var emptyLabel2: UILabel!
    @IBOutlet weak var evaluationImage: UIImageView!
    @IBOutlet weak var evaluationButton: UIButton!
    @IBOutlet weak var descView: UIView!
    @IBOutlet weak var emptyView: UIView!
    
    var evaluationDetailsData: EvaluationDetails?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Level \(evaluationDetailsData?.challenge?.level ?? 0)"
        
        self.evaluationImage.image = UIImage(data:evaluationDetailsData?.edited_image ?? Data())
        
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.tintColor = .black
        
        
        if evaluationDetailsData?.completed ?? false {
            emptyLabel1.isHidden = evaluationDetailsData?.completed ?? false
            emptyLabel2.isHidden = evaluationDetailsData?.completed ?? false
            emptyView.isHidden = evaluationDetailsData?.completed ?? false
            descTextView.text = evaluationDetailsData?.desc
        }
        
        // Do any additional setup after loading the view.
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is Step1Controller {
            
            print("SEGUEW pansgis;")
            
            let step1Controller = segue.destination as? Step1Controller
            step1Controller?.evaluationDetailsData = evaluationDetailsData

        }
    }
   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
