//
//  Step1Controller.swift
//  UrbanSnap
//
//  Created by Wilson Adrilia on 14/06/2021.
//

import UIKit

class Step1Controller: UIViewController {

    @IBOutlet weak var infoButton: UIImageView!
    @IBOutlet weak var step2Button: UIButton!
    @IBOutlet weak var infoDesc: DesignableView!
    
    @IBOutlet weak var lblMarkLayer: UILabel!
    @IBOutlet weak var imgCanvas: UIImageView!
    private var _selectedStickerView:StickerView?

    @IBAction func onInfoButton(_ sender: Any) {
        infoDesc.isHidden = !infoDesc.isHidden
    }
    
    var isEdited = false
    
    var selectedStickerView:StickerView? {
        get {
            return _selectedStickerView
        }
        set {
            // if other sticker choosed then resign the handler
            if _selectedStickerView != newValue {
                if let selectedStickerView = _selectedStickerView {
                    selectedStickerView.showEditingHandlers = false
                }
                _selectedStickerView = newValue
            }
            // assign handler to new sticker added
            if let selectedStickerView = _selectedStickerView {
                selectedStickerView.showEditingHandlers = true
                selectedStickerView.superview?.bringSubviewToFront(selectedStickerView)
            }
        }
    }

    var evaluationDetailsData: EvaluationDetails?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Step 1 of 3"
        self.navigationController?.navigationItem.title = "WDSDA"
        
        if let evaluationDetail = evaluationDetailsData {
            self.imgCanvas.image = UIImage(data:evaluationDetail.raw_image ?? Data())
            
            if let objectsData = evaluationDetail.challenge?.challengeObject?.allObjects as? [ChallengeObjects] {
                
                var layerMarkText = "There are \(objectsData.count) sticker on the top right corner that you can move & drag. Please mark the layers by using these stickers as follows:"
                
                for (index, _) in objectsData.enumerated() {
                    switch (index) {
                    case 0:
                        layerMarkText.append("\n\(index+1). Foreground")
                        break
                    case 1:
                        layerMarkText.append("\n\(index+1). Background")
                        break
                    case 2:
                        layerMarkText.append("\n\(index+1). Middleground")
                        break
                    default:
                        print("")
                    }
                }
                
                self.lblMarkLayer.text = layerMarkText
                
                for (index, _) in objectsData.enumerated() {
                    addTestImage(img: "\(index+1).circle.fill", index: index)
                }

            }
        }
       
   
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
    
    func addTestImage(img: String, index: Int){
        let testImage = UIImageView.init(frame: CGRect.init(x: 50, y: 50, width: 35, height: 35))
        testImage.image = UIImage(systemName: img)
        testImage.tintColor = .systemGreen
        testImage.contentMode = .scaleAspectFit
        let sticker1 = StickerView.init(contentView: testImage)
        
        print("boundw \(imgCanvas.frame.maxX)")
        sticker1.center = CGPoint.init(x: imgCanvas.frame.maxX - (35 + 30), y:  imgCanvas.frame.minY + CGFloat(40 * index) + 30)
        sticker1.delegate = self
        sticker1.enableFlip = false
        sticker1.enableClose = false
        sticker1.enableRotate = false
        sticker1.showEditingHandlers = false
        sticker1.tag = index
        self.imgCanvas.addSubview(sticker1)
        
    }
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is Step2Controller {
            
            if !isEdited {
                self.showAlert(title: "Alert", msg: "You are not moving any sticker yet!")
                return
            }
            
            print("SEGUEW pansgis;")
            
            let step2Controller = segue.destination as? Step2Controller
            
            if let image = saveImage(imageView: imgCanvas){
                step2Controller?.editedImage = image
                step2Controller?.evaluationDetailsData = evaluationDetailsData
            }else{
                print("Image not found !!")
            }
        }
    }

    func saveImage(imageView: UIImageView) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(imageView.frame.size, false, 0.0)
        imageView.superview!.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    
}


extension Step1Controller : StickerViewDelegate {
    func stickerViewDidTap(_ stickerView: StickerView) {
        self.selectedStickerView = stickerView
    }
    
    func stickerViewDidBeginMoving(_ stickerView: StickerView) {
        self.selectedStickerView = stickerView
        self.isEdited = true
    }
    
    func stickerViewDidChangeMoving(_ stickerView: StickerView) {
        
    }
    
    func stickerViewDidEndMoving(_ stickerView: StickerView) {
        
    }
    
    func stickerViewDidBeginRotating(_ stickerView: StickerView) {
        
    }
    
    func stickerViewDidChangeRotating(_ stickerView: StickerView) {
        
    }
    
    func stickerViewDidEndRotating(_ stickerView: StickerView) {
        
    }
    
    func stickerViewDidClose(_ stickerView: StickerView) {
        
    }
}
