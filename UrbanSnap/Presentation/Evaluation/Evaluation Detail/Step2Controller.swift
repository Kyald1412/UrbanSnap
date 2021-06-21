//
//  Step2Controller.swift
//  UrbanSnap
//
//  Created by Wilson Adrilia on 14/06/2021.
//

import UIKit

class Step2Controller: UIViewController {

    @IBOutlet weak var imageStep2: UIImageView!
    @IBOutlet weak var pencilButton: UIImageView!
    @IBOutlet weak var clearButton: UIImageView!
    @IBOutlet weak var step3Button: UIButton!
    @IBOutlet weak var infoDesc: DesignableView!
//    @IBOutlet weak var viewCanvas: Canvas!
    
    @IBOutlet weak var viewContent: UIView!
    var evaluationDetailsData: EvaluationDetails?
    var editedImage: UIImage = UIImage.init()
    
    let viewCanvas = Canvas()
     
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("sELF EDITES \(editedImage)")
        
        self.title = "Step 2 of 3"

        self.imageStep2.image = editedImage
        
        viewCanvas.backgroundColor = .clear
        viewCanvas.bounds = view.bounds
        viewCanvas.frame = view.frame
        viewCanvas.isUserInteractionEnabled = false
//        viewCanvas.translatesAutoresizingMaskIntoConstraints = false
        viewContent.addSubview(viewCanvas)

        NSLayoutConstraint.activate([
            viewCanvas.leadingAnchor.constraint(equalTo: viewContent.leadingAnchor),
            viewCanvas.trailingAnchor.constraint(equalTo: viewContent.trailingAnchor),
            viewCanvas.topAnchor.constraint(equalTo: viewContent.topAnchor),
            viewCanvas.bottomAnchor.constraint(equalTo: viewContent.bottomAnchor)
        ])

        addClearViewInfo()
        // Do any additional setup after loading the view.
    }
    
    func addClearViewInfo(){
        let viewInfoTapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideViewInfo))
        self.view.addGestureRecognizer(viewInfoTapGesture)
    }
    
    @objc func hideViewInfo(){
        infoDesc.isHidden = true
    }
    
    @IBAction func onPencilButton(_ sender: Any) {
        viewCanvas.isUserInteractionEnabled = !viewCanvas.isUserInteractionEnabled
        if viewCanvas.isUserInteractionEnabled {
            pencilButton.image = UIImage(systemName: "xmark.circle.fill")
        } else {
            pencilButton.image = UIImage(systemName: "pencil.circle.fill")
        }
    }
    
    @IBAction func onClearButton(_ sender: Any) {
        viewCanvas.undo()
    }
    
    @IBAction func onViewInfo(_ sender: Any) {
        infoDesc.isHidden = !infoDesc.isHidden
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is Step3Controller {
            
            print("SEGUEW pansgis;")
            
            if viewCanvas.lines.isEmpty {
                self.showAlert(title: "Alert", msg: "You are not drawing anything yet")
                return
            }
            
            let step3Controller = segue.destination as? Step3Controller
            step3Controller?.editedImage = viewContent.asImage()
            step3Controller?.evaluationDetailsData = evaluationDetailsData
          
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
